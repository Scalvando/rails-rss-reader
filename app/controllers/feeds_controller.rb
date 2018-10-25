# frozen_string_literal: true
require 'feedjira'

class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :destroy, :sync]

  def index
    @feeds = current_user.feeds.all
  end

  def show
    @entries = @feed.entries.order('published desc')
  end

  def new
    @feed = Feed.new
  end

  def sync
    puts @feed
    if @feed.sync
      redirect_to feed_path, notice: "Feed updated"
    end
  end

  def create
    feed = Feed.find_by_url(feed_params[:url])

    unless feed
      rss_feed = Feedjira::Feed.fetch_and_parse(feed_params[:url])

      new_feed = current_user.feeds.build(url: feed_params[:url], title: rss_feed.title, description: rss_feed.description)

      feed = new_feed if new_feed.save
    end

    current_user.feeds << feed
    flash[:success] = "Feed successfully added"
    redirect_to feeds_url
  end

  def destroy
    if current_user.feeds.delete(Feed.find(@feed.id))
      redirect_to feeds_url, notice: "Feed successfully deleted"
    end
  end

  private

  def set_feed
    @feed = current_user.feeds.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(:url)
  end
end
