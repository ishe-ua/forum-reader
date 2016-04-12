##
class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :email, null: false
      t.string :password_digest, null: false

      t.datetime :email_confirmation_at
      t.string :email_confirmation_token

      t.timestamps null: false
    end

    add_index :accounts, :email, unique: true

    add_index :accounts, :email_confirmation_at
    add_index :accounts, :email_confirmation_token, unique: true
  end
end
