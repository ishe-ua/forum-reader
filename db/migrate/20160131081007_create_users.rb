##
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :account, index: true, foreign_key: true

      t.string :email, null: false
      t.string :jabber

      t.timestamps null: false
    end

    add_index :users, :email,  unique: true
    add_index :users, :jabber, unique: true
  end
end
