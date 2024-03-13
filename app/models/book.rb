class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :date, presence: true
  validates :description, presence: true
  has_many :bookshelf_books
  has_many :bookshelves, through: :bookshelf_books
  has_many :reviews, dependent: :destroy
end
