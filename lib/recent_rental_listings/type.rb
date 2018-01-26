class RecentRentalListings::Type
  attr_accessor :name, :url, :city

  @@all = []

  def initialize(name, city, url)
    @name = name
    @city = city
    @url = url
    city.add_rental_type(self)
    @rentals = []
    @@all << self
  end

  def self.all
    @@all
  end

  def add_rental(rental)
    @rentals << rental
    rental.type = self
  end

  def rentals
    @rentals
  end


end
