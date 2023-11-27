import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
   // We'll talk about the connect in a second... 
   connect() {
      console.log("Hello, Stimulus!");
   }
}