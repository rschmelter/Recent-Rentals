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

  def cities
    @cities
  end

  # has many types through cities
  # has many rentals through cities.types

  def self.find_by_name(name)
    @@all.detect do |state|
      state.name == name
  end




end
