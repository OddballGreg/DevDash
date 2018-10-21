# frozen_string_literal: true

class ListDecorator < Draper::Decorator
  delegate_all
  include CardRelationDecorations
end
