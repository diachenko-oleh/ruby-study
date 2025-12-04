class Cinema
  attr_accessor :name, :location
  def initialize(name, location)
      @name = name
      @location = location
      @movies = []
  end

  def movies()
        return @movies
  end


  def add_movie(movie)
    @movies << movie
    movie.cinema = self
  end

  def self.general_overview()
    return("This is a cinema class")
  end
end

class Movie
  attr_accessor :title, :showtime, :cinema
  @@all = []
  def initialize(title, showtime)
    @title = title
    @showtime = showtime
    @@all << self
  end
end

cinema_1 = Cinema.new("N1","L1")
#puts cinema_1.methods()

movie_1 = Movie.new("MN1","st")

cinema_1.add_movie(movie_1)

p cinema_1.movies

cinema_2 = Cinema.new("N2","L2")
cinema_2.add_movie(movie_1)

p cinema_2.movies