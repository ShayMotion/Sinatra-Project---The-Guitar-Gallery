class CreateGuitars < ActiveRecord::Migration
  def change
      create_table :guitars do |t|
        t.string :brand
        t.string :model
        t.string :year
        t.float :price
    end
  end
end
