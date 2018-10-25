# frozen_string_literal: true

class Feed < ApplicationRecord
  validates :url, uniqueness: true

  has_many :entries,
    dependent: :destroy

  has_many :user_feeds, dependent: :destroy
  has_many :users, through: :user_feeds
end
