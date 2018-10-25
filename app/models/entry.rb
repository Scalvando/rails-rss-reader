# frozen_string_literal: true

class Entry < ApplicationRecord
  belongs_to :feed

  has_and_belongs_to_many :users
end
