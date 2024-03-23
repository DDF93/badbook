class AddHostToAttendee < ActiveRecord::Migration[7.1]
  def change
    add_column :attendees, :host, :boolean
  end
end
