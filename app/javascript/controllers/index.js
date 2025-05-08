import { application } from "controllers/application"
import HelloController from "controllers/hello_controller"
import AddRewardController from "controllers/add_reward_controller"
import PledgeFormController from "controllers/pledge_form_controller"

application.register("hello", HelloController)
application.register("add-reward", AddRewardController)
application.register("pledge-form", PledgeFormController)
