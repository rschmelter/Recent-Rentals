class RecentRentalListings::Type
  attr_accessor :name, :url, :city

  @@all = []

  def initialize(name, url, city)
    @name = name
    @city = city
    @url = url
    city.add_rental_type(self)
    @rentals = []
    @@all << self
  end

  def add_rentals(rental)
    @rentals << rental
    rental.type = self
  end

  def rentals
    @rentals
  end






end
