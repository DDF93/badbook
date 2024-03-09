class AddImageUrlToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :image_url, :string
    add_column :books, :google_id, :text
  end
end
