import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    if (!!this.element.getAttribute("data-dismiss-in")) {
      this.startDismissAnimation(
        parseInt(this.element.getAttribute("data-dismiss-in"))
      );
    }
  }

  startDismissAnimation(delay) {
    let duration = delay * 1000;
    let durationReduced = duration;

    let barBg = "#FFF";

    this.element.insertAdjacentHTML(
      "beforeend",
      `
            <div class="h-1 absolute left-0 bottom-0 alert-dismiss-indicator" style="background-color: ${barBg}"></div>
        `
    );
    this.alertDismissIndicator = this.element.querySelector(
      ":scope>div.alert-dismiss-indicator"
    );
    this.alertDismissIndicator.style.transition = "width 100ms linear";
    this.dismissAnimationInterval = setInterval(() => {
      durationReduced -= 100;
      if (durationReduced <= 0) {
        this.close();
      }
      this.alertDismissIndicator.style.width =
        (1 - durationReduced / duration) * 100 + "%";
    }, 100);
  }

  close() {
    if (!!this.dismissAnimationInterval)
      clearInterval(this.dismissAnimationInterval);
    this.element.classList.add("hide");
    setTimeout(() => {
      this.element.remove();
    }, 300);
  }
}
