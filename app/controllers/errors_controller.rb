# frozen_string_literal: true

class ErrorsController < ApplicationController
  def not_found
    render 'errors/not_found'
  end
end
