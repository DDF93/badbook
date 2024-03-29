class Session < ApplicationRecord
  belongs_to :book
  belongs_to :user
  has_many :attendees
  has_many :users, through: :attendees
  has_many :agendas, dependent: :destroy
  has_one :chatroom, dependent: :destroy
  after_create :create_chatroom_for_session

  private

  def create_chatroom_for_session
    # Ensure this line dynamically references the session's book title and ID
    create_chatroom(name: "Chat for #{book.title} Session")
  end
end
