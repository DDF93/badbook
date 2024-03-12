class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :bookshelves
  has_many :attendees
  has_many :sessions, through: :attendees
  after_create :create_default_bookshelf

  private

  def create_default_bookshelf
    bookshelves.create(name: 'Read Books')
  end
end
