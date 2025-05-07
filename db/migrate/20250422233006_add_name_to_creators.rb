class AddNameToCreators < ActiveRecord::Migration[8.0]
  def change
    add_column :creators, :name, :string
  end
end
