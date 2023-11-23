import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
	static targets = ["amount", "custom", "abv", "price"];
	static values = { vat: Number };
	calculate(event) {
		event.preventDefault();
		const amount = this.amountTarget.value === "custom"
			? parseFloat(this.customTarget.value)
			: parseFloat(this.amountTarget.value)

			console.log('AMOUNT' + amount);
			console.log(this.amountTarget);
		const abv = parseFloat(this.abvTarget.value);
		const price = parseFloat(this.priceTarget.value);
		// Amounts of alcohol tax per liter of pure alcohol for beers.
		let alcoholTax = 0;
		switch (true) {
				case (abv < 0.5):
					alcoholTax = 0;
				case (abv <= 3.5):
					alcoholTax = 0.2835;
				case (abv > 3.5):
					alcoholTax = 0.3805;
		}
		const beerTax = (amount * abv * alcoholTax);
		const vatAmount = (price - price / (1.0 + this.vatValue));
		const taxPercentage = ((beerTax + vatAmount) / price * 100);

		// search for the element where the result is shown
		const result = document.getElementById("result")
		result.innerHTML = `
			<p>Beer has ${beerTax.toFixed(2)} € of alcohol tax and ${vatAmount.toFixed(2)} € of value added tax.</p>
			<p> ${taxPercentage.toFixed(1)} % of the price is taxes.</p>`
  }
  reset(event) {
		event.preventDefault();
		amount_input.value = "0"
		custom_input.value = "0"
		abv_input.value = "0"
		price_input.value = "0"
  }
  change(event) {
    // a new option was selected!
    if (event.target.value === "custom"){
			document.getElementById("customDiv").style.display = "block"
		}else{
			document.getElementById("customDiv").style.display = "none"
		}
  } 
}