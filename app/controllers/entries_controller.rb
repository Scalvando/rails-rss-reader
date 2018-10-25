# frozen_string_literal: true

class EntriesController < ApplicationController
  before_action :set_entry, only: [:show]

  def index
    feeds = current_user.feeds.all
    @entries = []
    feeds.each do |feed|
      @entries.concat(feed.entries.all.order('published desc'))
    end

    @entries.sort! { |entry_a, entry_b| entry_b.published <=> entry_a.published }
  end

  private

  def set_entry
    @entry = current_user.entries.find(params[:id])
  end
end
