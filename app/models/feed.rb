# frozen_string_literal: true
require 'feedjira'

class Feed < ApplicationRecord
  validates :url, uniqueness: true

  has_many :entries,
    dependent: :destroy

  has_many :user_feeds, dependent: :destroy
  has_many :users, through: :user_feeds

  def sync
    content = Feedjira::Feed.fetch_and_parse(url)

    content.entries.each do |entry|
      local_entry = entries.where(title: entry.title).first_or_initialize
      local_entry.update_attributes(
        image: entry.image,
        summary: entry.summary,
        author: entry.author,
        url: entry.url,
        published: entry.published
      )
    end
  end
end
