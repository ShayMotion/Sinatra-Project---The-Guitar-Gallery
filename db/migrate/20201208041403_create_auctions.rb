class CreateAuctions < ActiveRecord::Migration
  def change
      create_table :auctions do |t|
      t.string :title
      t.datetime :start_date
      t.datetime :end_date
      t.integer :user_id
    end
  end
end
