class Star < ApplicationRecord
  has_many :starrings
  has_many :movies, through: :starrings

include Followable
end
