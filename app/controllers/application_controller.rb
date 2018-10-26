# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # https://stackoverflow.com/questions/25841377/rescue-from-actioncontrollerroutingerror-in-rails-4
  # if Rails.env.production?
  rescue_from ActionController::RoutingError, with: :render_not_found
  rescue_from AbstractController::ActionNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  # end

  private

  def render_not_found
    render template: "errors/not_found", status: 404
  end
end
