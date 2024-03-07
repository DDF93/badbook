class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :genre
      t.text :description
      t.integer :date

      t.timestamps
    end
  end
end
