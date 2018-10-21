# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    trello_token { 'token' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
