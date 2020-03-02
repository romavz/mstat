class Message < ApplicationRecord
  belongs_to :user

  validates :user, :text, presence: true
end
