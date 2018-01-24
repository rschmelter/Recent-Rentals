class RecentRentalListings::state

  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
    @cities = []
    @@all << self
  end





end
