# frozen_string_literal: true

class UserFeed < ApplicationRecord
  belongs_to :user
  belongs_to :feed

  validates :feed_id, uniqueness: { scope: :user_id, message: 'No duplicate feeds allowed' }
end
