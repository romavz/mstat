class User < ApplicationRecord
  has_many :messages, dependent: :destroy
  validates :email, :password, presence: true

  def authenticate?(password)
    self.password == password
  end

  def auth_token
    Auth.issue(user: id)
  end
end
