require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:messages).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe '#authenticate?' do
    let(:user) { create :user, email: 'some@mail.com', password: 'some_password' }

    context 'with valid password' do
      it 'should be true' do
        expect(user.authenticate?('some_password')).to eq true
      end
    end

    context 'with invalid password' do
      it 'should be false' do
        expect(user.authenticate?('invalid_password')).to eq false
      end
    end
  end

  describe '#auth_token' do
    let(:user) { create :user }

    it 'return auth token for user id' do
      expect(user.auth_token).to eq Auth.issue(user: user.id)
    end
  end

end
