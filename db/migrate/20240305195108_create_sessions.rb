class CreateSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :sessions do |t|
      t.references :book, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :capacity
      t.datetime :start_time
      t.string :video_link

      t.timestamps
    end
  end
end
