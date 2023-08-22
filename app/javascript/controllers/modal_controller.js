import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect(){
    console.log("CONNECTER !");
  }
  close(event) {
    console.log(event)
    console.log(event.target)
    this.element.classList.add("hidden");
    this.element.innerHTML = ""
  }
}
