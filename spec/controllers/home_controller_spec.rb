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
end
