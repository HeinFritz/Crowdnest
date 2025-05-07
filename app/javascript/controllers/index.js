// app/javascript/controllers/index.js
import { application } from "./application"

// Explicitly import each controller so they get bundled
import HelloController from "controllers/hello_controller"
import AddRewardController from "controllers/add_reward_controller"

// Register them on your Stimulus app
application.register("hello", HelloController)
application.register("add-reward", AddRewardController)
