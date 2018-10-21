# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListsController, type: :controller do
  login_user_before_each

  let (:board) { FactoryBot.create(:board) }
  let (:list) { FactoryBot.create(:list) }

  describe 'GET #index' do
    it 'returns http success' do
      get :index, params: { board_id: board.id }
      expect(response).to have_http_status(:success)
    end
  end
end
