class User < ApplicationRecord
  has_many :messages, dependent: :destroy
  validates :email, :password, presence: true
end
