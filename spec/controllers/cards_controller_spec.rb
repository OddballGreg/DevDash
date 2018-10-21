# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  login_user_before_each

  let (:card) { FactoryBot.create(:card) }

  describe 'GET #index' do
    it 'returns http success' do
      get :index, params: { board_id: card.list.board.id, list_id: card.list.id }
      expect(response).to have_http_status(:success)
    end
  end
end
