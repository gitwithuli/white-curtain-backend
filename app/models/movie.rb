class Movie < ApplicationRecord
  belongs_to :genre
  has_many :starrings, dependent: :destroy
  has_many :stars, through: :starrings, dependent: :destroy

  include Followable

  def self.get_recommendations(user)
    movies_by_genre = Movie.where(genre_id: user.followed_genres.pick(:id)).where.not(id: user.followed_movies.pick(:id))
    movies_by_stars = Movie.includes(:stars).where(stars: {id: user.followed_stars.pick(:id)}).where.not(id: user.followed_movies.pick(:id))

    return {
      by_genre: movies_by_genre,
      by_stars: movies_by_stars
    }
  end
end


