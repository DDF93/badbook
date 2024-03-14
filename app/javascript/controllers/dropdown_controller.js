import { Controller } from "@hotwired/stimulus"
import { leave, toggle } from "el-transition"

export default class extends Controller {
  // The "button" is the element that you click to toggle the dropdown.
  // The "menu" contains the dropdown menu items, this is typically a div.
  static targets = ["menu", "button"]

  /*
  / Toggle the visiblity of the menu based on if it's shown or not. The name
  / is not shadowed because our custom toggle method would be this.toggle(),
  / not toggle() which is supplied by el-transition.
  /
  / el-transition will hide or show this element (our menu) and apply the
  / transition classes that are defined as data attributes in the HTML.
  */
  toggle() {
    toggle(this.menuTarget)
  }

  // We only want to hide the menu when we click anything except the button.
  // This lets us click anywhere outside of the dropdown menu to hide it.
  hide(event) {
    const buttonClicked = this.buttonTarget.contains(event.target)

    if (!buttonClicked) {
      leave(this.menuTarget)
    }
  }
}
