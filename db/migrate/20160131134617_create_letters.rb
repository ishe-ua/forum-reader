class CreateLetters < ActiveRecord::Migration[5.0]
  def change
    create_table :letters do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name

      t.boolean :d1
      t.boolean :d2
      t.boolean :d3
      t.boolean :d4
      t.boolean :d5
      t.boolean :d6
      t.boolean :d7

      t.integer :hour
      t.integer :minute

      t.datetime :last_post_at
      t.integer :position

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
