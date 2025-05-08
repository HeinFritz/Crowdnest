import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select", "amount"]

  connect() {
    if (this.hasSelectTarget) {
      const selectedOption = this.selectTarget.selectedOptions[0];
      const amount = selectedOption?.dataset.amount;
      if (amount) {
        this.amountTarget.value = amount;
      }
    }
  }

  syncAmount() {
    const selected = this.selectTarget.selectedOptions[0]
    const amount = selected.dataset.amount
    if (amount) {
      this.amountTarget.value = amount
    }
  }
}
