class RecentRentalListings::Rental
  attr_accessor :type, :list_date, :list_number, :description, :price, :size, :area, :url, :city

  @@all = []

  def initialize(city, type, list_number)
    @type = type
    @city = city
    @list_number = list_number
    type.add_rental(self)
    @@all << self
  end




end
