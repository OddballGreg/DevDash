# frozen_string_literal: true

FactoryBot.define do
  factory :board do
    user
    name { Faker::Internet::name }
  end
end
