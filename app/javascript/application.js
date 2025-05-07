import "@hotwired/turbo-rails"
import Rails from "@rails/ujs"
Rails.start()
window.Rails = Rails

import "@hotwired/stimulus-loading"  // ✅ correct built-in stimulus-loading
import "controllers"

console.log("Rails UJS loaded?", !!window.Rails);
