# frozen_string_literal: true

class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.string :title
      t.datetime :published
      t.text :summary
      t.text :url
      t.string :author
      t.text :image
      t.integer :feed_id

      t.timestamps
    end
  end
end
