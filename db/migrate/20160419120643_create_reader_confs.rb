class CreateReaderConfs < ActiveRecord::Migration
  def change
    create_table :reader_confs do |t|
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
