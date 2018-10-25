# frozen_string_literal: true

class UserEntry < ApplicationRecord
  belongs_to :user
  belongs_to :entry
end
