# frozen_string_literal: true
require 'feedjira'

class FeedsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_feed, only: [:show, :destroy, :sync]
  before_action :set_feeds, only: [:index, :create, :destroy]

  def index
    @feeds = @feeds.all
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
    if @feeds.find_by_url(feed_params[:url])
      redirect_to feeds_url, alert: "Subscription already exists"
      return
    end
    feed = Feed.find_by_url(feed_params[:url])

    unless feed
      begin
        content = Feedjira::Feed.fetch_and_parse(feed_params[:url])

        new_feed = @feeds.build(
          url: feed_params[:url],
          title: content.title,
          description: content.description
        )

        feed = new_feed if new_feed.save
      rescue
        redirect_to feeds_url, alert: "Could not parse feed"
        return
      end
    end

    @feeds << feed
    redirect_to feeds_url, notice: "Feed added"
  end

  def destroy
    if @feeds.delete(@feeds.find(@feed.id))
      redirect_to feeds_url, notice: "Feed deleted"
    end
  end

  private

  def set_feed
    @feed = current_user.feeds.find(params[:id])
  end

  def set_feeds
    @feeds = current_user.feeds
  end

  def feed_params
    params.require(:feed).permit(:url)
  end
end
