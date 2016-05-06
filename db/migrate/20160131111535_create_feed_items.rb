class CreateFeedItems < ActiveRecord::Migration
  def change
    create_table :feed_items do |t|
      t.references :feed, index: true, foreign_key: true

      t.datetime :date
      t.string   :url
      t.string   :theme
      t.text     :text

      t.timestamps null: false
    end

    add_index :feed_items, :created_at
  end
end
