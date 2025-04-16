#!/usr/bin/env bash

# Use while read loop instead of for loop with find
find . -type d | while read -r D; do
  echo "Entered directory $D"
  cd "$D" || continue

  # Define the image types to search for
  image_types=("*.jpeg" "*.jpg" "*.tiff" "*.tif" "*.png")

  # Iterate over each image type
  for type in "${image_types[@]}"; do
    # Find files of the specified image type
    find . -type f -iname "$type" | while read -r IMAGE; do
      # Get the filename without extension
      filename_without_extension=${IMAGE%.*}

      # Convert the image to WebP format with separate parameters
      cwebp -m 6 -q 50 -mt -af -progress "$IMAGE" -o "${filename_without_extension}.webp"

      echo "Converted $IMAGE to ${filename_without_extension}.webp"

      rm -rf "$IMAGE"
    done
  done

  # Return to original directory
  cd - >/dev/null || exit 1
done

echo "Conversion complete."
