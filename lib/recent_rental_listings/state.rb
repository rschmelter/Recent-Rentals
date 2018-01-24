class RecentRentalListings::state

  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
    @cities = []
    @@all << self
  end

  def self.all
    @@all
  end

  def add_city(city)
    @cities << city
    city.state = self
  end



end
