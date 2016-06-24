class AddUserToAuction < ActiveRecord::Migration
  def change
    change_table :auctions do |t|
      t.references :user
    end

    add_index :auctions, :user_id

  end
end
