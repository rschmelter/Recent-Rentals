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
    puts "Select the number of the state to see a list of cities to choose from."
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
      if (1..state.cities.length).include?(city_number)
        valid = true
        selection = state.cities[city_number - 1]
        show_types(selection)
      else
        puts "Invalid selection. Please type the number of a city to see the types of rentals available."
        puts " "
      end
    end
  end

  def show_types(city)
    RecentRentalListings::Scraper.new.make_types(city.url).each do |array|
      RecentRentalListings::Type.new(array[0],
      city,
      array[1]
      )
    end
    city.types.each_with_index do |type, index|
      puts "#{index + 1}. #{type.name}"
    end
    puts " "
    puts "Select the number of an option to see the most recently listed rentals."
    puts " "
    valid = false
    while valid == false
      input = gets.strip
      type_number = input.to_i
      if (1..city.types.length).include?(type_number)
        valid = true
        selection = city.types[type_number - 1]
        get_rentals(city, selection)
      else
        puts "Invalid selection. Please select the number of a rental type to see the most recent rentals in your chosen city."
        puts " "
      end
    end
  end

  def get_rentals(city, type)
    result_hash = RecentRentalListings::Scraper.new.make_rentals(type.url)

    result_hash.each do |key, value|
      RecentRentalListings::Rental.new(city, type, key.to_s)
    end
    i = 1
      type.rentals.each do |rental|
        rental.list_date = result_hash[i][0]
        rental.description = result_hash[i][1]
        rental.price = result_hash[i][2]
        rental.size = result_hash[i][3]
        rental.area = result_hash[i][4]
        rental.url = result_hash[i][5]
        i += 1
     end
     show_rentals(city, type)
   end

   def show_rentals(city, type)
     i = 1
     type.rentals.each do |rental|
      puts "#{i})"
      puts "Date Listed: #{rental.list_date}"
      puts "Description: #{rental.description}"
      puts "Price: #{rental.price}"
      puts "Size: #{rental.size}"
      puts "Area: #{rental.area}"
      puts "___________________________________________________________"
      puts ""
    i += 1
      end
      select_rental(city, type)
    end

    def select_rental(city, type)
      puts "Select the number of a rental to see the poster's description."
      valid = false
      while valid == false
        input = gets.strip
        rental_number = input.to_i
        if (1..type.rentals.length).include?(rental_number)
          valid = true
          selection = type.rentals[rental_number - 1]
          show_description(city, type, selection.url)
        else
          puts "Invalid selection. Please select a number of a rental to see a description."
        end
      end
    end

    def show_description(city, type, url)
      post = RecentRentalListings::Scraper.new.make_post(url)
      puts " "
      puts "____________________________________________________________"
      puts " "
      post.each do |graph|
        puts "#{graph}"
      end
      puts " "
      puts " "
      puts "____________________________________________________________"
      puts " "
      puts "To see more options, type 'more', or type 'quit' to exit"
      valid = false
      while valid == false
        input = gets.strip
        if input.downcase == "more"
          reset(city, type)
        elsif input.downcase == "quit"
          exit
        else
          puts "Invalid input. Please type 'more' or 'quit'"
        end
      end
    end


    def reset(city, type)
      puts " "
      puts "Type 'rentals' to see more of this type of rental in this city. Type 'city' to see other options in this state. Type 'state' to see a list of states, or 'quit' to exit"
      valid = false
      while valid == false
          input = gets.strip
        if input.downcase == "city"
          valid = true
          show_cities(city.state)
        elsif input.downcase == "state"
          valid = true
          show_states
        elsif input.downcase == "rentals"
          show_rentals(city, type)
        elsif input.downcase == "quit"
          valid = true
          puts "Have a nice day!"
          exit
        else
          puts "Invalid input. Please select a valid option."
        end
      end
    end

end
