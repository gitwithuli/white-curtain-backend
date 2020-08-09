class MovieSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :year
  belongs_to :genre
end
