class AddAuctionIdToGuitars < ActiveRecord::Migration
  def change
    add_column :guitars, :auction_id, :integer
  end
end
