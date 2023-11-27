import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
   static targets = ["name", "year", "active"];

   connect() {
      console.log("Hello, Stimulus!");
   }

   reset(event) {
      event.preventDefault();
      this.nameTarget.value = '';
      this.activeTarget.checked = false;
      this.yearTarget.value = '';
   }
}