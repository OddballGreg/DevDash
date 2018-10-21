# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TrelloTrackingJob do
  let (:user) { FactoryBot.create(:user) }
  let (:tracking_job_double) { double }

  it 'triggers the trello tracker services refresh for the relevant user' do
    expect(TrelloTracker).to receive(:new).with(instance_of(Integer)).and_call_original
    expect_any_instance_of(TrelloTracker).to receive(:refresh_user_information!)
    TrelloTrackingJob.perform_now(user.id)
  end
end
