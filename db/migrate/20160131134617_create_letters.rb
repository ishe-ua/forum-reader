class CreateLetters < ActiveRecord::Migration
  def change
    create_table :letters do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name, null: false

      t.boolean :d1, null: false, default: false
      t.boolean :d2, null: false, default: false
      t.boolean :d3, null: false, default: false
      t.boolean :d4, null: false, default: false
      t.boolean :d5, null: false, default: false
      t.boolean :d6, null: false, default: false
      t.boolean :d7, null: false, default: false

      t.integer :hour, null: false
      t.integer :minute, null: false

      t.datetime :last_post_at, null: false
      t.integer :position, null: false

      t.timestamps null: false
    end

    add_index :letters, :last_post_at

    add_index :letters, :d1
    add_index :letters, :d2
    add_index :letters, :d3
    add_index :letters, :d4
    add_index :letters, :d5
    add_index :letters, :d6
    add_index :letters, :d7

    add_index :letters, :hour
    add_index :letters, :minute
  end
end
