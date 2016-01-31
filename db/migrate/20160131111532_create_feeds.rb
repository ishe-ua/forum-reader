class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :url, null: false
      t.datetime :fetched_at, default: nil

      t.timestamps null: false
    end

    add_index :feeds, :url, unique: true
    add_index :feeds, :fetched_at
  end
end
