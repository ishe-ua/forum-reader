class CreateMailerSets < ActiveRecord::Migration[5.0]
  def change
    create_table :mailer_sets do |t|
      t.references :user, index: true, foreign_key: true
      t.string :secret_name, null: false

      t.integer :status
      t.datetime :last_post_at

      t.timestamps null: false
    end

    add_index :mailer_sets, :status
    add_index :mailer_sets, :last_post_at
    add_index :mailer_sets, :secret_name, unique: true
  end
end
