class Api::V1::MoviesController < Api::V1::BaseController
   before_action :authenticate_user, only: [:follow, :unfollow]

  def index
    render json: MovieSerializer.new(Movie.all).serialized_json
  end

  def follow
    movie = Movie.find(params[:movie_id])
    current_user.followed_movies.push movie
    render json: MovieSerializer.new(current_user.followed_movies).serialized_json
  end

  def unfollow
    Follow.where(user_id: current_user.id, followable_type: "Movie",
      followable_id: params[:movie_id]).first.destroy
    render json: MovieSerializer.new(current_user.followed_movies).serialized_json
  end
end
