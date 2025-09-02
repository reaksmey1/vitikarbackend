class ChangeStartTimeAndEndTimeToStringInEvents < ActiveRecord::Migration[8.0]
  def up
    change_column :events, :start_time, :string
    change_column :events, :end_time, :string
  end

  def down
    change_column :events, :start_time, :datetime
    change_column :events, :end_time, :datetime
  end
end
