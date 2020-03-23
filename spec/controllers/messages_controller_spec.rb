require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  render_views

  describe 'GET #index' do
    let!(:user) { create :user }
    let!(:messages) { create_list :message, 2 }
    let!(:user_message) { create :message, user: user }

    before { get :index, format: :json }

    it 'it populate messages list' do
      expect(assigns(:messages)).to match_array(Message.all)
    end

    it 'renders index template' do
      expect(response).to render_template :index
    end

    it 'return status success' do
      expect(response).to have_http_status :success
    end

    it 'return all messages' do
      response_messages_ids = json['messages'].map { |msg| msg['id'] }
      expect(response_messages_ids).to match_array(Message.all.map(&:id))
    end
  end

  describe 'GET #show' do
    let!(:messages) { create_list :message, 2 }
    before { get :show, params: params, format: :json }

    context 'with existing message id' do
      let!(:params) { { id: messages.last } }
      it 'renders show template' do
        expect(response).to render_template :show
      end

      it 'populate message' do
        expect(assigns(:message)).to eq messages.last
      end

      it 'return status success' do
        expect(response).to have_http_status :success
      end
    end

    context 'with invalid message id' do
      let!(:params) { { id: 0 } }

      it 'return status - not found' do
        expect(response).to have_http_status :not_found
      end
    end
  end

  describe 'POST #create' do
    let!(:user) { create :user }
    let(:make_request) { post :create, params: { message: { text: 'some test text' } }, format: :json }

    context 'with user token' do
      before { auth_with_user(user) }

      it 'returns status - created' do
        expect(make_request).to have_http_status :created
      end

      it 'add new user message' do
        expect { make_request }.to change(user.messages, :count).to(1)
      end
    end

    context 'without user token' do
      it 'return status - unauthorized' do
        expect(make_request).to have_http_status :unauthorized
      end

      it 'do not change messages count' do
        expect { make_request }.to_not change(Message, :count)
      end
    end
  end
end
