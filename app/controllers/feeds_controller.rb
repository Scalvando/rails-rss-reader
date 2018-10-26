# frozen_string_literal: true
require 'feedjira'

class FeedsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_feed, only: [:show, :destroy, :sync]
  before_action :set_user_feeds, only: [:index, :create, :destroy]

  def index
    @feeds = @user_feeds.all
  end

  def show
    @entries = @feed.entries.order('published desc')
  end

  def new
    @feed = Feed.new
  end

  def sync
    if @feed.sync
      redirect_to feed_path, notice: "Feed updated"
    end
  end

  def create
    if @user_feeds.find_by_url(feed_params[:url])
      redirect_to feeds_url, alert: "Subscription already exists"
    else
      feed = Feed.find_by_url(feed_params[:url])

      unless feed
        content = Feedjira::Feed.fetch_and_parse(feed_params[:url])

        new_feed = @user_feeds.build(
          url: feed_params[:url],
          title: content.title,
          description: content.description
        )

        feed = new_feed if new_feed.save
      end

      @user_feeds << feed
      redirect_to feeds_url, notice: "Feed added"
    end
  end

  def destroy
    if @user_feeds.delete(@user_feeds.find(@feed.id))
      redirect_to feeds_url, notice: "Feed deleted"
    end
  end

  private

  def set_feed
    @feed = current_user.feeds.find(params[:id])
  end

  def set_user_feeds
    @user_feeds = current_user.feeds
  end

  def feed_params
    params.require(:feed).permit(:url)
  end
end
