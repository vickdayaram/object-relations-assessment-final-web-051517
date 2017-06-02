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
