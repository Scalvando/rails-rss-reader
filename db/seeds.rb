# frozen_string_literal: true
require "feedjira"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!([
  { email: 'demo@test.com', password: 'secret123', password_confirmation: 'secret123' },
  { email: 'test@test.com', password: 'secret1234', password_confirmation: 'secret1234' },
])

puts 'Users creates'

feed_urls = ['https://feeds.bbci.co.uk/news/world/rss.xml', 'https://www.theregister.co.uk/security/headlines.atom']

feed_urls.each do |feed_url|
  content = Feedjira::Feed.fetch_and_parse(feed_url)

  feed = Feed.new(
    url: feed_url,
    title: content.title,
    description: content.description
  )

  if feed.save
    puts "Feed for #{feed_url} created"
  end

  if feed.sync
    puts "Feed successfully synced"
  end
end

user_demo = User.find_by_email('demo@test.com')

user_test = User.find_by_email('test@test.com')

user_demo.feeds << Feed.find_by_url(feed_urls[0])

puts 'Added feeds to user demo'

user_test.feeds << Feed.all

puts 'Added feeds to user demo'

user_demo.feeds.all.each do |user_feed|
  user_demo.entries << user_feed.entries.all.limit(3)
end

puts 'Added saved entries to user demo'

user_test.feeds.all.each do |user_feed|
  user_test.entries << user_feed.entries.all.limit(2)
end

puts 'Added saved entries to user test'
