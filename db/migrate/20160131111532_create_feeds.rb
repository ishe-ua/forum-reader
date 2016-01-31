class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :url, null: false
      t.datetime :last_fetch_at, default: nil

      t.timestamps null: false
    end

    ###
    #
    #

    add_index :feeds, :url, unique: true
    add_index :feeds, :last_fetch_at
  end
end
