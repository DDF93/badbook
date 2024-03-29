class AddUrlToSessions < ActiveRecord::Migration[7.1]
  def change
    add_column :sessions, :host_url, :string
    add_column :sessions, :room_url, :string
  end
end
