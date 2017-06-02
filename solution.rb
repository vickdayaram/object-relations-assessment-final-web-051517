# Please copy/paste all three classes into this file to submit your solution!


class Viewer
  attr_accessor :first_name, :last_name

  @@all = []

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @@all << self
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.all
    @@all
  end

  def self.find_by_name(name)
    name_split = name.split(" ")
    self.all.find do |viewer|
      viewer.first_name == name_split[0] && viewer.last_name == name_split[1]
    end
  end

  def create_rating(score, movie)
    new_movie = Movie.find_or_create(movie)
    Rating.new(new_movie, score, self)
  end
end


class Rating

  attr_accessor :score
  attr_reader :viewer, :movie
  @@all = []

  def initialize(movie, score, viewer)
    @movie = movie
    @score = score
    @viewer = viewer
    @@all << self
  end


  def self.all
    @@all
  end
end



class Movie

  attr_accessor :title

  @@all = []

  def initialize(title)
    self.title = title
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find_by_title(title)
    self.all.find do |movie|
      movie.title == title
    end
  end

  def self.find_or_create(title)
    if self.all.find {|movie| movie.title == title}
       self.all.find {|movie| movie.title == title}
    else
    Movie.new(title)
    end
  end

  def ratings
    Rating.all.select do |rating|
      rating.movie == self
    end
  end

  def viewers
    viewers_array = []
    Rating.all.each do |ratings|
      if ratings.movie == self
        viewers_array.push(ratings.viewer)
      end
    end
    viewers_array
  end

  def average_rating
    average = []
    Rating.all.each do |ratings|
      if ratings.movie == self
        average.push(ratings.score)
      end
    end
    sum = 0
    average.each do |score|
      sum += score
    end
    average_number = sum / average.length
    average_number
  end
end
