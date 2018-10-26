# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # https://stackoverflow.com/questions/25841377/rescue-from-actioncontrollerroutingerror-in-rails-4
  unless Rails.application.config.consider_all_requests_local
    rescue_from ActionController::RoutingError, with: -> { render_404 }
    rescue_from ActionController::UnknownController, with: -> { render_404 }
    rescue_from ActiveRecord::RecordNotFound, with: -> { render_404 }
  end

  def render_404
    respond_to do |_type|
      format.html { render template: "errors/not_found", status: 404 }
      format.all { render nothing: true, status: 404 }
    end
    true
  end
end
