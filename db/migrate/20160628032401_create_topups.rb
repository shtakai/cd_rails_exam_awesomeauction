class CreateTopups < ActiveRecord::Migration
  def change
    create_table :topups do |t|
      t.decimal :amount
      t.references :wallet, index: true, foreign_key: true
      t.text :note

      t.timestamps null: false
    end
  end
end
