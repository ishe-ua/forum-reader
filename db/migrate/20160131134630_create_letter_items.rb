class CreateLetterItems < ActiveRecord::Migration[5.0]
  def change
    create_table :letter_items do |t|
      t.references :letter, index: true, foreign_key: true

      t.string :name
      t.string :url

      t.datetime :last_post_at
      t.integer :position

      t.timestamps null: false
    end

    add_index :letter_items, :url
    add_index :letter_items, :last_post_at
  end
end
