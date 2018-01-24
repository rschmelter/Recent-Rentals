
class RecentRentalListings::City
  attr_accessor :name, :state, :url

  @@all = []

  def initialize(name, state, url)
    @name = name
    @state = state
    @url = url
    @types = []
    state.add_city(self)
    @@all << self
  end

  def self.all?
    @@all
  end

  def add_rental_type(type)
    @types << type
    type.rental = self
  end

  def types
    @types
  end

  def rentals
    self.types.collect do |type|
      type.rentals
    end
  end




end
