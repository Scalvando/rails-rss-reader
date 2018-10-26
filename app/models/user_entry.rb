# frozen_string_literal: true

class UserEntry < ApplicationRecord
  belongs_to :user
  belongs_to :entry

  validates :entry_id, uniqueness: { scope: :user_id, message: 'No duplicate entries allowed' }
end
