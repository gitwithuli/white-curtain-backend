class GenreSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :id
end
