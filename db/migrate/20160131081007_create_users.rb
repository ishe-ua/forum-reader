##
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :account, index: true, foreign_key: true
      t.string :jabber

      t.datetime :jabber_confirmation_at
      t.string   :jabber_confirmation_token

      t.timestamps null: false
    end

    add_index :users, :jabber, unique: true

    add_index :users, :jabber_confirmation_at
    add_index :users, :jabber_confirmation_token, unique: true
  end
end
