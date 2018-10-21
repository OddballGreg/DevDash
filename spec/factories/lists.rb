# frozen_string_literal: true

FactoryBot.define do
  factory :list do
    board
    name { Faker::Internet.name }
  end
end
