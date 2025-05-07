class RemoveImageFromProjects < ActiveRecord::Migration[8.0]
  def change
    remove_column :projects, :image, :string
  end
end
