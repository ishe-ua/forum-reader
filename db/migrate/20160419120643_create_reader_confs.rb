class CreateReaderConfs < ActiveRecord::Migration
  def change
    create_table :reader_confs do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :status, null: false

      t.timestamps null: false
    end

    add_index :reader_confs, :status
  end
end
