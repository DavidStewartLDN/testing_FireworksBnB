class User < ActiveRecord::Base
  has_many :spaces
  has_many :bookings
end