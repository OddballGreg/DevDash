# frozen_string_literal: true

class TrelloTrackingJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    TrelloTracker.new(user_id).refresh_user_information!
  end
end
