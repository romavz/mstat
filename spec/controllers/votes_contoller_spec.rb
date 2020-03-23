require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  let!(:user) { create :user }
  let!(:message) { create :message }
  let(:message_id) { message.id }
  let(:make_vote) { post :create, params: { vote: { message_id: message_id } }, format: :json }

  describe 'POST #create' do
    context 'with user token' do
      before { auth_with_user(user) }

      context 'with valid message id' do
        it 'add new vote' do
          expect { make_vote }.to change(Vote, :count).to(1)
        end

        it 'return status - created' do
          expect(make_vote).to have_http_status :created
        end
      end

      context 'with invalid message id' do
        let(:message_id) { Message.last.id + 100 }

        it 'return status - forbidden' do
          expect(make_vote).to have_http_status :forbidden
        end

        it 'must return error messages' do
          make_vote
          expect(json['errors']).to_not be_empty
        end

        it 'do not change votes count' do
          expect { make_vote }.to_not change(Vote, :count)
        end
      end
    end

    context 'without user token' do
      it 'return status - unauthorized' do
        expect(make_vote).to have_http_status :unauthorized
      end
    end
  end
end
