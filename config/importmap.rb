# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "controllers/add_reward_controller", to: "controllers/add_reward_controller.js"
pin "@rails/ujs", to: "@rails--ujs.js" # @7.1.3
pin_all_from "app/javascript/controllers", under: "controllers"
