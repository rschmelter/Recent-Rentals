require 'open-uri'
require 'nokogiri'


class RecentRentalListings::Scraper

  def scrape_states

    @states = []
    doc = Nokogiri::HTML(open('https://www.craigslist.org/about/sites'))
    a = doc.css(".colmask").first
      a.css(".box h4").each do |state|
        @states << state.text
      end
      @states
  end

  def hash_builder_states
    @state_hash = {}
    @states.each do |state|
      @state_hash[state] = []
      end
    @state_hash
  end

  def get_city_nodes
    @city_nodes = []
    doc = Nokogiri::HTML(open('https://www.craigslist.org/about/sites'))
    a = doc.css(".colmask").first
    a.css(".box ul").each do |nodes|
      @city_nodes << nodes
    end
    @city_nodes
  end

  def get_city_arrays
    i = 0
    @text_array = []
    @city_arrays = []
    @city_nodes.collect do |node|
      @text_array << node.text
    end
    @text_array.collect do |cities|
      @city_arrays << cities.split("\n")
    end
    @city_arrays.collect do |array|
      array.pop
      array.shift
    end
    @city_arrays
  end



end