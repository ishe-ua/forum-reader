class CreateLetterItems < ActiveRecord::Migration
  def change
    create_table :letter_items do |t|
      t.references :letter, index: true, foreign_key: true

      t.string :name, null: false
      t.string :url, null: false

      t.datetime :last_post_at
      t.integer :position, null: false

      t.timestamps null: false
    end

    ###
    #
    #

    add_index :letter_items, :name
    add_index :letter_items, :url
    add_index :letter_items, :last_post_at
  end
end
