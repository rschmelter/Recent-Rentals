
class RecentRentalListings::City
  attr_accessor :name, :state, :url

  @@all = []

  def initialize(name, state, url)
    @name = name
    @state = state
    @url = url
    state.add_city(self)
    @@all << self
  end

  def self.all?
    @@all
  end





end
