class MakeRewardIdNullableInPledges < ActiveRecord::Migration[8.0]
  def change
    change_column_null :pledges, :reward_id, true
  end
end
