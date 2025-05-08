class CreatePledges < ActiveRecord::Migration[8.0]
  def change
    create_table :pledges do |t|
      t.references :backer, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.references :reward, null: false, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
