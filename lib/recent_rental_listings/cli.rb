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

  def show_states
    puts "To get started, type 'list' to show a list of states and areas with available rentals. Or type the name of the state."
    puts " "
      valid = false
  end







end
