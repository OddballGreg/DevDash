# frozen_string_literal: true

class TrelloTrackingJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    TrelloTracker.refresh!(user_id)
  end
end
