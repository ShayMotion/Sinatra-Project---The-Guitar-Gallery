class Guitar < ActiveRecord::Base
    belongs_to :auction
    has_one :user, through: :auction
    
    validates :brand, :model, :year, :price, presence: true
end