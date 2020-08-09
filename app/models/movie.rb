class Movie < ApplicationRecord
  belongs_to :genre
  has_many :starrings
  has_many :stars, through: :starrings

  include Followable
end


