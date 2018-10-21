# frozen_string_literal: true

class CardsController < ApplicationController
  def index
    @list = List.find(params[:list_id]).decorate
  end
end
