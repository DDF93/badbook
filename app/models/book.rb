class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :date, presence: true
  validates :description, presence: true
  has_many :bookshelf_books
  has_many :bookshelves, through: :bookshelf_books
  has_many :reviews, dependent: :destroy
  has_many :sessions

  include PgSearch::Model

  pg_search_scope :search_book,
    against: [:title, :description, :author, :genre],
    using: {
      tsearch: { prefix: true }
    }
end
