class CreateReaderSets < ActiveRecord::Migration
  def change
    create_table :reader_sets do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :status

      t.timestamps null: false
    end

    add_index :reader_sets, :status
  end
end
