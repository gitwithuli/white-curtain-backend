class Api::V1::UserTokenController < Knock::AuthTokenController

  def create
    user = User.find(entity.id)
    render json:{
      jwt: auth_token.token,
      user: UserSerializer.new(user, {include: [:followed_movies, :followed_stars, :followed_genres]}).serializable_hash
    }
  end
end
