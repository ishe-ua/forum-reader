class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :letter, index: true, foreign_key: true

      t.string :name, null: false
      t.string :url, null: false

      t.datetime :last_post_at, null: false
      t.integer :position, null: false

      t.timestamps null: false
    end

    add_index :items, :name
    add_index :items, :url
    add_index :items, :last_post_at
  end
end
