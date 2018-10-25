# frozen_string_literal: true

class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entry, only: [:save, :destroy]
  before_action :set_feeds, only: [:index, :sync]
  before_action :set_entries, only: [:save, :saved, :destroy]
  def index
    @entries = []
    @feeds.each do |feed|
      @entries.concat(feed.entries.all.order('published desc'))
    end

    @entries.sort! { |entry_a, entry_b| entry_b.published <=> entry_a.published }
  end

  def sync
    if @feeds.all.each(&:sync)
      redirect_to entries_path, notice: "Feeds updated"
    end
  end

  def saved
    @entries = current_user.entries.all.order('published desc')
  end

  def save
    @entries << @entry
    flash[:success] = "Article successfully saved"
    redirect_back fallback_location: root_path
  end

  def destroy
    if @entries.delete(@entry)
      redirect_to saved_entries_path, notice: "Article successfully deleted"
    end
  end

  private

  def set_saved_entry
    @entry = @entries.find(params[:id])
  end

  def set_entry
    @entry = Entry.find(params[:id])
  end

  def set_feeds
    @feeds = current_user.feeds
  end

  def set_entries
    @entries = current_user.entries
  end
end
