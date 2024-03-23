class AddEndTimeToSessions < ActiveRecord::Migration[7.1]
  def change
    add_column :sessions, :end_time, :datetime
  end
end
