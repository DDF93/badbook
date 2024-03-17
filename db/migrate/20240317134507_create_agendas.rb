class CreateAgendas < ActiveRecord::Migration[7.1]
  def change
    create_table :agendas do |t|
      t.text :content
      t.references :session, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :upvotes
      t.integer :downvotes

      t.timestamps
    end
  end
end
