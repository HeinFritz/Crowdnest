class CreateRewards < ActiveRecord::Migration[8.0]
  def change
    create_table :rewards do |t|
      t.string :name
      t.text :description
      t.integer :amount
      t.date :delivery_date
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
