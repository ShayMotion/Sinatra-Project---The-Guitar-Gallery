class Auction < ActiveRecord::Base
    has_many :guitars
    belongs_to :user

    validates :title, :user, presence: true
    validates :title, uniqueness: true
    validates :start_date, :end_date, presence: true

    def slug
        self.title.downcase.split(" ").join("-")
      end
    
      def self.find_by_slug(slug)
        Auction.all.detect {|x| slug == x.slug}
      end
end

