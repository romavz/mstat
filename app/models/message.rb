class Message < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :destroy

  validates :user, :text, presence: true
end
