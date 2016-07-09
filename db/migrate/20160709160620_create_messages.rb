class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :user, index: true, foreign_key: true

      t.string :from
      t.string :subject
      t.text :body
      t.text :attachments

      t.timestamps null: false
    end

    add_index :messages, :created_at
  end
end
