# frozen_string_literal: true

FactoryBot.define do
  factory :card do
    list
    name { Faker::Internet.name }
  end
end
