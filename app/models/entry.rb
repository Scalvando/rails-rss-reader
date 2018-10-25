# frozen_string_literal: true

class Entry < ApplicationRecord
  belongs_to :feed

  has_many :user_entries, dependent: :destroy
  has_many :users, through: :user_entries
end
