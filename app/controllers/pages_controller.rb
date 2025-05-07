class PagesController < ApplicationController
  def home
    # @projects = Project.all.order(created_at: :desc)
    @projects = Project.where(launched: true)  # Fetch launched projects only
  end
end
