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
      while valid == false
        input = gets.strip
        split_input = input.split(" ").collect {|part| part.capitalize}
        detect_input = split_input.join(" ")
        state_object = HousingList::State.find_by_name(detect_input)
        if state_object != nil
        valid = true
        show_cities(state_object)

      end

    end

  end







end
