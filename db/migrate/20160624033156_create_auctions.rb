class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :product_name
      t.text :description
      t.decimal :starting_bid
      t.decimal :reserve_price
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
