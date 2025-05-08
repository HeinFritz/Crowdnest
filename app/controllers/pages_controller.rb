# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  def home
    if params[:query].present?
      @projects = Project.where("title ILIKE ?", "%#{params[:query]}%")
    elsif params[:category].present?
      @projects = Project.where(category: params[:category])
    else
      @projects = Project.all
    end
  end
end
