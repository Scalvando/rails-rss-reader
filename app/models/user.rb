# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable

  has_many :user_feeds, dependent: :destroy
  has_many :user_entries, dependent: :destroy
  has_many :feeds, through: :user_feeds
  has_many :entries, through: :user_entries
end
