class CreateFeeds < ActiveRecord::Migration[5.0]
  def change
    create_table :feeds do |t|
      t.string :url
      t.datetime :last_fetch_at

      t.timestamps null: false
    end

    add_index :feeds, :url, unique: true
    add_index :feeds, :last_fetch_at
  end
end
