class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :email,  null: false
      t.string :theme,  null: false
      t.text   :text,   null: false

      t.timestamps null: false
    end

    add_index :contacts, :email
  end
end
