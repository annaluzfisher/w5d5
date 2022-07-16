def eighties_b_movies
  # List all the movies from 1980-1989 with scores falling between 3 and 5
  # (inclusive). Show the id, title, year, and score.
  Movie.where('yr BETWEEN 1980 AND 1989 AND score BETWEEN 3 AND 5').select(:id, :title, :yr, :score)
  

end

def bad_years
  # List the years in which no movie with a rating above 8 was released.
  Movie
  .group(:yr)
  .having('MAX(score) < 8 ')
  .pluck(:yr)
  
end

def cast_list(title)
  # List all the actors for a particular movie, given the title.
  # Sort the results by starring order (ord). Show the actor id and name.
  Actor
  .joins(:movies)
  .where('title = (?)', title)
  .order('ord asc')
  .select(:id, :name)

  # SElect arctors.id , actors.name FROM actors INNER JOIN castings on castincs.actor_id 
  #inner join move on movie.id = casting.movie_id where (title = ('star wars') order by ord asc)


end

def vanity_projects
  # List the title of all movies in which the director also appeared as the
  # starring actor. Show the movie id, title, and director's name.

  # Note: Directors appear in the 'actors' table.
  Movie
  .joins(:actors)
  .select('movies.title, movies.id, actors.name') 
  .where('castings.ord = 1 AND movies.director_id = castings.actor_id')
end

def most_supportive
  Actor
  .select('actors.id , actors.name , count(actors.id) AS roles')
  .joins(:castings)
  .where('castings.ord > 1')
  .group('actors.id')
  .order('count(actors.id) desc')
  .limit(2)
  # Find the two actors with the largest number of non-starring roles.
  # Show each actor's id, name, and number of supporting roles.
  
end