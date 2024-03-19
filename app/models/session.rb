class Session < ApplicationRecord
  belongs_to :book
  has_many :attendees
  has_many :users, through: :attendees
  has_many :agendas, dependent: :destroy
end
