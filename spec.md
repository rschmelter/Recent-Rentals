# Specifications for the CLI Assessment

Specs:
- [x] Have a CLI for interfacing with the application
  In the bin folder, recent-rentals calls start in cli.rb. This presents the user with options and asks for input. The user continues to select options (state, city, rental type, and rental) until they are presented with a description of a particular rental. The user can then choose to see more rental options or choose another state or city. The program will continue asking for input until the user types 'quit'.

- [x] Pull data from an external source
  Upon starting the application, the Craigslist index page is scraped for all states and cities. Once the user has selected a state and city, the city url is scraped for rental types. Once the user selects a rental type, the rental type url is scraped for basic information (listing date, short description, price, size, area), and presented to the user as a list. Once the user selects a rental, the posting page is scraped for the full description and presented to the user.

- [x] Implement both list and detail views
  The user is presented with a list of states. Once a state is selected, the user is presented with a list of cities. Once a city is selected, the user is presented with a list of rental types. Once a rental type is selected, the user is presented with a list of rentals and some basic information on each one. The user can then select a rental to be presented with a full description of that specific rental.
