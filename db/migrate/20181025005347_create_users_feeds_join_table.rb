# frozen_string_literal: true

class CreateUsersFeedsJoinTable < ActiveRecord::Migration[5.2]
  create_join_table :users, :feeds do |t|
    t.index :user_id
    t.index :feed_id
  end
end
