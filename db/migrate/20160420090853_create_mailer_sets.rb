class CreateMailerSets < ActiveRecord::Migration
  def change
    create_table :mailer_sets do |t|
      t.references :user, index: true, foreign_key: true

      t.integer :status
      t.datetime :last_post_at

      t.timestamps null: false
    end

    add_index :mailer_sets, :status
    add_index :mailer_sets, :last_post_at
  end
end
