require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:messages).dependent(:destroy)}
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
end