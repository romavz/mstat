require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    let!(:user) { create :user, email: 'mail@xxx.com', password: '12345' }
    before { post :create, params: { auth: auth }, format: :json }

    context 'incorrect email' do
      let!(:auth) { { email: 'incorrect', password: user.password } }
      it 'return response status - unauthorized' do
        expect(response).to have_http_status :unauthorized
      end
    end

    context 'incorrect password' do
      let(:auth) { { email: user.email, password: 'wrong password' } }
      it 'return response status - unauthorized' do
        expect(response).to have_http_status :unauthorized
      end
    end

    context 'when correct password and email' do
      let!(:auth) { { email: user.email, password: user.password } }

      it 'return response status - success' do
        expect(response).to have_http_status :success
      end

      it 'fill response API-AUTH-TOKEN' do
        expect(json['api_auth_token']).to eq user.auth_token
      end
    end

  end
end
