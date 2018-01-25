class RecentRentalListings::CLI

  def start
    @states_array = []
    @state_hash = RecentRentalListings::Scraper.new.make_states_cities
    @state_hash.keys.each do |state|
      state = RecentRentalListings::State.new(state)
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
        state_object = RecentRentalListings::State.find_by_name(detect_input)
        if state_object != nil
          valid = true
          show_cities(state_object)
        elsif input.downcase == "list"
          valid = true
          i = 1
          @states_array.each do |state|
            puts "#{i}. #{state.name}"
            i += 1
        end
        puts " "
        select_state
        else
          puts "invalid input. Please type 'list' to show states, or type the state name."
          puts " "
      end
    end
  end

  def select_state
    puts "Type the number of the state to see a list of cities to choose from."
    puts " "
    valid = false
    while valid == false
      input = gets.strip
      state_number = input.to_i
      if (1..52).include?(state_number)
        valid = true
        selection = @states_array[state_number - 1]
        show_cities(selection)
      else
        puts "Invalid selection. Please choose a number between 1 and 52"
        puts " "
      end
    end
  end

  def show_cities(state)
    city_array = @state_hash[state.name]
    zipped_array = city_array[0].zip(city_array[1])
    zipped_array.each do |array|
      RecentRentalListings::City.new(array[0],
      state,
      array[1]
      )
    end
    state.cities.each_with_index do |city, index|
      puts "#{index + 1}. #{city.name.strip}"
    end
    puts " "
    puts "Select the number of the city to see the types of rentals that are available."
    puts " "
    valid = false
    while valid == false
      input = gets.strip
      city_number = input.to_i
    end
    if (1..state.cities.length).include?(city_number)
      valid = true
      selection = state.cities[city_number - 1]
      show_options(selection)

    end
  end







end
