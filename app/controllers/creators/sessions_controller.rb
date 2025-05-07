class Creators::SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    if resource.is_a?(Creator)
      step1_project_steps_path  # Go to project creation step 1 after login
    else
      super
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
