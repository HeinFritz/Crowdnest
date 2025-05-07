// app/javascript/controllers/index.js
import { application } from "controllers/application"  // This is correct now

// Import and register controllers
import HelloController from "controllers/hello_controller"
import AddRewardController from "controllers/add_reward_controller"

application.register("hello", HelloController)
application.register("add-reward", AddRewardController)
