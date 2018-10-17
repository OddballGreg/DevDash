# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BoardsController, type: :controller do
  login_user_before_each

  let (:board) {FactoryBot.create(:board)}

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: {id: board.id}
      expect(response).to have_http_status(:success)
    end
  end
end
