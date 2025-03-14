{ pkgs, ... }:

let
  # Helper script to download a single image
  downloadImageScript = pkgs.writeShellApplication {
    name = "download-image";
    runtimeInputs = with pkgs; [
      curl
      gnugrep
      coreutils
    ];
    text = ''
      # This script downloads a single image
      # Args: node_id image_url target_dir child_map_file format

      NODE_ID="$1"
      IMAGE_URL="$2"
      TARGET_DIR="$3"
      CHILD_MAP="$4"
      FORMAT="$5"

      # Look up the node name from our mapping
      NODE_NAME=$(grep "^$NODE_ID," "$CHILD_MAP" | cut -d',' -f2)
      if [ -z "$NODE_NAME" ]; then
          # Fallback to using node ID as filename
          NODE_NAME="node_$NODE_ID"
      fi

      # Create a clean filename
      FILENAME="$(echo "$NODE_NAME" | tr ' /' '_')"
      TARGET_FILE="$TARGET_DIR/$FILENAME.$FORMAT"

      # Check if file already exists
      if [ -f "$TARGET_FILE" ] && [ -s "$TARGET_FILE" ]; then
          echo "Skipping: $FILENAME.$FORMAT (already exists)"
          exit 0
      fi

      echo "Downloading: $FILENAME.$FORMAT"
      curl -s "$IMAGE_URL" -o "$TARGET_FILE"

      # Verify the download was successful
      if [ ! -s "$TARGET_FILE" ]; then
          echo "Warning: Downloaded file is empty or failed to download: $FILENAME.$FORMAT"
          rm -f "$TARGET_FILE"  # Clean up empty file
          exit 1
      else
          echo "Successfully downloaded: $FILENAME.$FORMAT"
          exit 0
      fi
    '';
  };
in
pkgs.writeShellApplication {
  name = "figma-sync";
  runtimeInputs = with pkgs; [
    curl
    jq
    coreutils
    gnugrep
    gnused
    findutils
    downloadImageScript
  ];
  text = ''
    # Configuration variables - read from environment (set by direnv)
    if [ -z "$FIGMA_TOKEN" ]; then
      echo "Error: FIGMA_TOKEN is not set. Make sure it's defined in .envrc.local"
      exit 1
    fi

    if [ -z "$FIGMA_FILE_ID" ]; then
      echo "Error: FIGMA_FILE_ID is not set. Make sure it's defined in .envrc.local"
      exit 1
    fi

    # Get the node ID from environment or extract from URL
    FIGMA_NODE_ID=''${FIGMA_NODE_ID:-""}
    FIGMA_NODE_URL=''${FIGMA_NODE_URL:-""}

    # If we have a URL but no node ID, extract the node ID from the URL
    if [ -z "$FIGMA_NODE_ID" ] && [ -n "$FIGMA_NODE_URL" ]; then
      # Extract node-id from URL like https://www.figma.com/design/3XcV2s13KqXMMsEPradoh3/Name?node-id=1523-4&t=...
      FIGMA_NODE_ID=$(echo "$FIGMA_NODE_URL" | grep -o 'node-id=[^&]*' | cut -d= -f2 | tr -d '%')
      
      # Replace dash with colon for Figma API format (1523-4 -> 1523:4)
      FIGMA_NODE_ID=$(echo "$FIGMA_NODE_ID" | tr '-' ':')
    fi

    # Check if we have a node ID
    if [ -z "$FIGMA_NODE_ID" ]; then
      echo "Error: No node ID provided. Either set FIGMA_NODE_ID or FIGMA_NODE_URL in .envrc.local"
      echo "Example URL format: https://www.figma.com/design/FILE_ID/Name?node-id=1523-4&t=..."
      exit 1
    fi

    # Set the number of parallel downloads (default to number of CPU cores)
    NUM_CORES=''${NUM_CORES:-$(nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 4)}
    echo "Using $NUM_CORES parallel download processes"

    SVELTEKIT_ASSETS_DIR=''${SVELTEKIT_ASSETS_DIR:-"./src/lib/assets"}
    TEMP_DIR=''${TEMP_DIR:-"./temp_figma_assets"}
    FORMAT=''${FORMAT:-"png"}
    SCALE=''${SCALE:-"1"}

    # Create directories if they don't exist
    mkdir -p "$SVELTEKIT_ASSETS_DIR"
    mkdir -p "$TEMP_DIR"

    echo "Starting Figma assets sync for node ID: $FIGMA_NODE_ID..."

    # Print debug info (masked token for security)
    echo "Debug info:"
    echo "- File ID: $FIGMA_FILE_ID"
    echo "- Node ID: $FIGMA_NODE_ID"
    MASKED_TOKEN="$(echo "$FIGMA_TOKEN" | cut -c1-4)...$(echo "$FIGMA_TOKEN" | rev | cut -c1-4 | rev)"
    echo "- Token: $MASKED_TOKEN"

    # Step 1: Get information about the node
    echo "Fetching node information..."
    NODE_URL="https://api.figma.com/v1/files/$FIGMA_FILE_ID/nodes?ids=$FIGMA_NODE_ID"
    echo "API URL: $NODE_URL"

    # Use a temporary file to store the response
    curl -s -H "X-Figma-Token: $FIGMA_TOKEN" "$NODE_URL" > "$TEMP_DIR/node_response.json"

    # Check if the API request was successful
    if grep -q "error" "$TEMP_DIR/node_response.json"; then
        echo "Error fetching node information from Figma:"
        cat "$TEMP_DIR/node_response.json"
        rm -f "$TEMP_DIR/node_response.json"
        exit 1
    fi

    # Extract node type and name
    NODE_TYPE=$(jq -r --arg id "$FIGMA_NODE_ID" '.nodes[$id].document.type // "Unknown"' "$TEMP_DIR/node_response.json")
    NODE_NAME=$(jq -r --arg id "$FIGMA_NODE_ID" '.nodes[$id].document.name // "Unknown"' "$TEMP_DIR/node_response.json")

    echo "Found node: $NODE_NAME (Type: $NODE_TYPE)"

    # If this is a CANVAS node, we need to extract its children
    if [ "$NODE_TYPE" = "CANVAS" ]; then
        echo "This is a Canvas/Page node. Extracting child nodes to export..."
        
        # Create a target directory for the assets
        TARGET_DIR="$SVELTEKIT_ASSETS_DIR"
        mkdir -p "$TARGET_DIR"
        
        # Extract all child IDs as a comma-separated list for batch export
        CHILD_IDS=$(jq -r --arg id "$FIGMA_NODE_ID" '.nodes[$id].document.children[].id' "$TEMP_DIR/node_response.json" | tr '\n' ',' | sed 's/,$//')
        
        # Save child names for later reference
        jq -r --arg id "$FIGMA_NODE_ID" '.nodes[$id].document.children[] | .id + "," + .name' "$TEMP_DIR/node_response.json" > "$TEMP_DIR/child_map.txt"
        
        # Count the number of children
        CHILD_COUNT=$(jq -r --arg id "$FIGMA_NODE_ID" '.nodes[$id].document.children | length' "$TEMP_DIR/node_response.json")
        echo "Found $CHILD_COUNT child nodes to export."
        
        if [ -z "$CHILD_IDS" ] || [ "$CHILD_COUNT" -eq 0 ]; then
            echo "No child nodes found in this Canvas."
            rm -f "$TEMP_DIR/node_response.json" "$TEMP_DIR/child_map.txt"
            exit 1
        fi
        
        # Step 2: Export all child nodes in a single request (more efficient)
        echo "Requesting batch export of all child nodes..."
        EXPORT_URL="https://api.figma.com/v1/images/$FIGMA_FILE_ID?ids=$CHILD_IDS&format=$FORMAT&scale=$SCALE"
        echo "API URL: $EXPORT_URL (truncated)"
        
        curl -s -H "X-Figma-Token: $FIGMA_TOKEN" "$EXPORT_URL" > "$TEMP_DIR/export_response.json"
        
        # Check if the API request was successful
        if grep -q "error" "$TEMP_DIR/export_response.json"; then
            echo "Error exporting images from Figma:"
            cat "$TEMP_DIR/export_response.json"
            rm -f "$TEMP_DIR/export_response.json" "$TEMP_DIR/child_map.txt"
            exit 1
        fi
        
        # Step 3: Download each image in parallel
        echo "Processing image export response..."
        
        # Extract all image URLs into a file with format: node_id,image_url
        jq -r '.images | to_entries[] | .key + "," + .value' "$TEMP_DIR/export_response.json" > "$TEMP_DIR/image_urls.txt"
        
        # Filter out null URLs
        grep -v ",null$" "$TEMP_DIR/image_urls.txt" > "$TEMP_DIR/valid_urls.txt"
        
        echo "Downloading images in parallel using $NUM_CORES processes..."
        
        # Process each line individually to avoid shellcheck warnings
        while IFS=',' read -r NODE_ID IMAGE_URL; do
            # Add to a queue of background processes
            (
                download-image "$NODE_ID" "$IMAGE_URL" "$TARGET_DIR" "$TEMP_DIR/child_map.txt" "$FORMAT"
            ) &
            
            # Limit the number of parallel processes
            RUNNING_JOBS=$(jobs -p | wc -l)
            if [ "$RUNNING_JOBS" -ge "$NUM_CORES" ]; then
                # Wait for a job to finish before continuing
                wait -n
            fi
        done < "$TEMP_DIR/valid_urls.txt"
        
        # Wait for all remaining jobs to finish
        wait
        
    else
        # If not a canvas, just export the current node
        echo "Exporting single node: $NODE_NAME"
        
        # Create target directory
        TARGET_DIR="$SVELTEKIT_ASSETS_DIR"
        mkdir -p "$TARGET_DIR"
        
        # Request image export
        EXPORT_URL="https://api.figma.com/v1/images/$FIGMA_FILE_ID?ids=$FIGMA_NODE_ID&format=$FORMAT&scale=$SCALE"
        echo "API URL: $EXPORT_URL"
        
        curl -s -H "X-Figma-Token: $FIGMA_TOKEN" "$EXPORT_URL" > "$TEMP_DIR/export_response.json"
        
        # Check if the API request was successful
        if grep -q "error" "$TEMP_DIR/export_response.json"; then
            echo "Error exporting image from Figma:"
            cat "$TEMP_DIR/export_response.json"
            rm -f "$TEMP_DIR/export_response.json"
            exit 1
        fi

        # Extract image URL
        IMAGE_URL=$(jq -r --arg id "$FIGMA_NODE_ID" '.images[$id]' "$TEMP_DIR/export_response.json")
        
        # Check if we found an image URL
        if [ -z "$IMAGE_URL" ] || [ "$IMAGE_URL" = "null" ]; then
            echo "No image URL found for node $FIGMA_NODE_ID."
            echo "This might be because:"
            echo "1. The node doesn't contain exportable content"
            echo "2. The node ID is incorrect"
            echo "3. You don't have permission to export this node"
            cat "$TEMP_DIR/export_response.json"
            rm -f "$TEMP_DIR/export_response.json"
            exit 1
        fi

        # Download the image
        FILENAME="$(echo "$NODE_NAME" | tr ' /' '_')"
        echo "Downloading: $FILENAME.$FORMAT"
        
        curl -s "$IMAGE_URL" -o "$TARGET_DIR/$FILENAME.$FORMAT"
        
        # Verify the download was successful
        if [ ! -s "$TARGET_DIR/$FILENAME.$FORMAT" ]; then
            echo "Error: Downloaded file is empty or failed to download"
            exit 1
        else
            echo "Image saved to: $TARGET_DIR/$FILENAME.$FORMAT"
        fi
    fi

    # Clean up temporary files
    rm -f "$TEMP_DIR/node_response.json" "$TEMP_DIR/export_response.json" "$TEMP_DIR/child_map.txt" 
    rm -f "$TEMP_DIR/image_urls.txt" "$TEMP_DIR/valid_urls.txt"
    rmdir "$TEMP_DIR" 2>/dev/null || true

    # List the downloaded files
    if [ -d "$TARGET_DIR" ]; then
        echo "Figma assets successfully synced to: $TARGET_DIR"
        echo "Downloaded files:"
        ls -la "$TARGET_DIR"
        
        # Count the number of successfully downloaded files
        FILE_COUNT=$(find "$TARGET_DIR" -type f -name "*.$FORMAT" | wc -l)
        echo "Successfully downloaded $FILE_COUNT files."
    else
        echo "No files were downloaded."
    fi

    echo "All done!"
  '';
}
