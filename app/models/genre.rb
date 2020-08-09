class Genre < ApplicationRecord
  has_many :movies

include Followable
end
