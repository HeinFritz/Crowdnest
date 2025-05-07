class AddNameToBackers < ActiveRecord::Migration[8.0]
  def change
    add_column :backers, :name, :string
  end
end
