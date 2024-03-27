class Session < ApplicationRecord
  belongs_to :book
  belongs_to :user
  has_many :attendees
  has_many :users, through: :attendees
  has_many :agendas, dependent: :destroy
end
