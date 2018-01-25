class RecentRentalListings::State

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

  def cities
    @cities
  end

  def types
    self.cities.collect do |city|
      city.types
    end
  end

  def rentals
    self.types.collect do |type|
      type.rentals
    end
  end

  def self.find_by_name(name)
    @@all.detect do |state|
      state.name == name
  end
 end




end
