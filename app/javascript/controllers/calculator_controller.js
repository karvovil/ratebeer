import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
   static targets = ["amount", "abv", "price"];

   calculate(event) {
      // Prevent the default form submission from reloading the page.
      event.preventDefault();
      const amount = parseFloat(this.amountTarget.value);
      const abv = parseFloat(this.abvTarget.value);
      const price = parseFloat(this.priceTarget.value);
      console.log(amount, abv, price);
   }
}