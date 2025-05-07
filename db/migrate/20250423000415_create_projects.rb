class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :subtitle
      t.text :description
      t.integer :goal
      t.date :deadline
      t.string :category
      t.string :location
      t.string :image
      t.references :creator, null: false, foreign_key: true

      t.timestamps
    end
  end
end
