
module RecentRentalListings
  # Your code goes here...
end

require 'open-uri'
require 'pry'
require 'nokogiri'

require_relative "recent_rental_listings/version"
require_relative "recent_rental_listings/scraper"
require_relative "recent_rental_listings/state"
require_relative "recent_rental_listings/city"
require_relative "recent_rental_listings/type"
require_relative "recent_rental_listings/rental"
require_relative "recent_rental_listings/cli"
