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
