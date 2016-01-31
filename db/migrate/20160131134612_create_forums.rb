class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.references :user, index: true, foreign_key: true

      t.string :name, null: false
      t.string :url, null: false

      t.integer :target, null: false
      t.datetime :last_post_at, null: false

      t.integer :position, null: false
      t.timestamps null: false
    end

    add_index :forums, :name
    add_index :forums, :url

    add_index :forums, :last_post_at
    add_index :forums, :target
  end
end
