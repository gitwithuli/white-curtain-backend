# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'httparty'

Tmdb::Api.key(ENV[“MOVIE_API”])


puts "Cleaning up the database...."

Genre.destroy_all
Movie.destroy_all
Star.destroy_all

puts "DB cleaned....."

puts "Creating Genres"
genre_search = Tmdb::Genre.list
genres = genre_search.flatten(2)
genres.shift
genres.each do |genre|
  created_genres = Genre.create(
    id: genre["id"],
    name: genre["name"]
    )
end

puts "Genres created!"

puts "Creating a fresh batch of movies...."

movies = Tmdb::Movie.top_rated

movies.each do |movie|
  genre_for_search = Tmdb::Movie.detail(movie.id)
  genre_for_search.slice!("genres")
  almost_genre = genre_for_search["genres"]
  last_genre = almost_genre[0]["id"]

  created_movies = Movie.create(
    id: movie.id,
    title: movie.title,
    year: movie.release_date,
    description: movie.overview,
    poster: movie.poster_path,
    genre_id: last_genre

    )
end

puts "Movies created!"
puts "Creating fresh batch of stars!"

movie_titles = Movie.all.pluck(:title)
movie_titles.delete("Gabriel's Inferno Part II")
movie_titles.each do |title|
  url = "http://www.omdbapi.com/?t=#{title}&apikey=#{ENV[“OMDB_API_KEY”]}"
  response = HTTParty.get(url)
  json = JSON.parse(response.body)
  star_search = json["Actors"].split(", ")
  star_search.each do |star|
    Star.create(
      name: star )
  end
end
puts "Ended..."
