class CreateTopics < ActiveRecord::Migration[7.1]
  def change
    create_table :topics do |t|
      t.references :session, null: false, foreign_key: true
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.integer :votes

      t.timestamps
    end
  end
end
