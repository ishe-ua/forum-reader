class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :theme
      t.text   :text

      t.timestamps null: false
    end

    add_index :contacts, :email
  end
end
