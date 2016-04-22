class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.references :user, index: true, foreign_key: true

      t.string :name
      t.string :url

      t.integer :target
      t.integer :position

      t.datetime :last_post_at
      t.timestamps null: false
    end

    add_index :forums, :url
    add_index :forums, :target
    add_index :forums, :last_post_at
  end
end
