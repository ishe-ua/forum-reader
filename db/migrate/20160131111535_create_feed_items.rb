# coding: utf-8
class CreateFeedItems < ActiveRecord::Migration
  def change
    create_table :feed_items do |t|
      t.references :feed, index: true, foreign_key: true
      t.string :digest, null: false

      t.datetime :date
      t.text :link
      t.text :titl
      t.text :body

      t.timestamps null: false
    end

    add_index :feed_items, [:feed_id, :digest], unique: true
    add_index :feed_items, :created_at # очистка от устаревших
  end
end
