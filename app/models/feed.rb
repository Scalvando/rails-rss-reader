# frozen_string_literal: true

class Feed < ApplicationRecord
  has_many :entries,
    dependent: :destroy

  has_and_belongs_to_many :users
end
