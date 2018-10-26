# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # https://stackoverflow.com/questions/25841377/rescue-from-actioncontrollerroutingerror-in-rails-4
  # if Rails.env.production?
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from AbstractController::ActionNotFound, with: :render_404
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  # end

  private

  def render_404
    render template: "errors/not_found", status: 404
  end
end
