class RecentRentalListings::CLI

  def start
    @states_array = []
    @state_hash = HousingList::Scraper.new.make_states_cities
    @state_hash.keys.each do |state|
      state = HousingList::State.new(state)
      @states_array << state
    end
    puts "Welcome!"
    puts " "
    show_states
  end








end
