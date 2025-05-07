class AddLaunchedToProjects < ActiveRecord::Migration[8.0]
  def change
    add_column :projects, :launched, :boolean
  end
end
