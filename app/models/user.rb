class User < ActiveRecord::Base
    has_many :auctions
    has_many :guitars, through: :auctions
  
    validates :email, :password, :username, presence: true
    validates :email, :username, uniqueness: true
  
    def authenticate(password)
      if self.password == password
        self
      else
        false
      end
    end
  
  end