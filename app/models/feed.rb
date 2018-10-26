# frozen_string_literal: true
require 'feedjira'

class Feed < ApplicationRecord
  validates :url, uniqueness: true

  has_many :entries,
    dependent: :destroy

  has_many :user_feeds, dependent: :destroy
  has_many :users, through: :user_feeds

  def sync
    # https://www.sitepoint.com/building-an-rss-reader-in-rails-is-easy/
    content = Feedjira::Feed.fetch_and_parse(url)

    content.entries.each do |entry|
      local_entry = entries.where(url: entry.url).first_or_initialize
      local_entry.update_attributes(
        title: entry.title,
        image: entry.image,
        summary: entry.summary,
        author: entry.author,
        published: entry.published
      )
    end
  end
end
