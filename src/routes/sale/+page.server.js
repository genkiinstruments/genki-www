import { redirect } from "@sveltejs/kit";

export async function load() {
	redirect(302, "https://buy.stripe.com/9B64gz1H1e6vabd1Ca5c406?prefilled_promo_code=ULTIMATE30");
}