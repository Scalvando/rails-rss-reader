# frozen_string_literal: true

class CreateFeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :feeds do |t|
      t.string :title
      t.text :url
      t.text :description

      t.timestamps
    end
  end
end
