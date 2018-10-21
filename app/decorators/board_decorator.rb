# frozen_string_literal: true

class BoardDecorator < Draper::Decorator
  delegate_all
  include CardRelationDecorations
  include ListRelationDecorations
end
