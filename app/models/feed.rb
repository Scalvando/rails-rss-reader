# frozen_string_literal: true

class Feed < ApplicationRecord
  has_many :entries, dependent: :destroy
end
