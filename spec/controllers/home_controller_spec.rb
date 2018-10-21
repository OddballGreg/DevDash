# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  login_user_before_each

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #trigger_refresh' do
    context 'if user has trello token defined' do
      it 'triggers a sidekiq trellotrackerjob' do
        expect(TrelloTrackingJob).to receive(:perform_later).with(instance_of(Integer))
        post :trigger_refresh
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'if user does not have trello token defined' do
      it 'redirect them to the index with an alert' do
        User.update_all(trello_token: nil)
        post :trigger_refresh
        expect(response).to have_http_status(:redirect)
        expect(flash[:alert]).to eq('Cannot refresh without valid user token!')
      end
    end
  end

  describe 'POST #save_trello_token' do
    it 'saves the posted token to the given users record' do
      post :save_trello_token, params: { trello_token: 'new_token' }
      expect(response).to have_http_status(:redirect)
      expect(User.where(trello_token: 'new_token').count).to eq 1
    end
  end
end
