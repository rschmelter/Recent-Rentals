require 'open-uri'
require 'nokogiri'
require 'pry'


class RecentRentalListings::Scraper


  def make_states_cities
    scrape_states
    hash_builder_states
    get_city_nodes
    get_city_arrays
    get_city_urls
    hash_builder_state_city_url
  end

  def make_types(url)
    scrape_rental_types_block(url)
    scrape_rental_types
    scrape_rental_types_href
    rental_types_and_urls
  end

  def make_rentals(url)
    scrape_listing_page(url)
  end

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

  def get_city_urls
    @city_urls = []
    i = 0
    @city_nodes.each do |group|
      @city_urls[i] = []
      group.css("li").each do |city|
        info = city.children
        url = info.attribute("href").value
        @city_urls[i] << url
      end
      i += 1
    end
    @city_urls
  end

  def hash_builder_state_city_url
    keys = @state_hash.keys
    i = 0
    keys.each do |state|
      @state_hash[state] << @city_arrays[i]
      @state_hash[state] << @city_urls[i]
      i += 1
    end
    @state_hash

  end

  def scrape_rental_types_block(url)
    @url = url
    html = open(url)
    doc = Nokogiri::HTML(html)
    @rental_block = doc.css(".housing ul").first
    @rental_block
  end

  def scrape_rental_types
    remove_at_index = [1, 2, 3, 4, 5, 7]
    @rental_options = []
    @rental_block.css("li").each do |type|
      @rental_options << type.text
    end
    @rental_options = @rental_options.reject.with_index do |e, i|
      remove_at_index.include?(i)
    end
    @rental_options
  end

  def scrape_rental_types_href
    @root = @url.chomp("/")
    @rental_urls = []
    i = 0
    remove_at_index = [1, 2, 3, 4, 5, 7]
    @rental_block.css("li").collect do |item|
      @rental_urls << item.children.attribute("href").value
  end
    @rental_urls.collect do |url|
      @rental_urls[i] = "#{@root}#{url}"
      i += 1
  end
    @rental_urls = @rental_urls.reject.with_index do |e, i|
      remove_at_index.include?(i)
  end
    @rental_urls
  end

  def rental_types_and_urls
    @rental_options_and_urls = @rental_options.zip(@rental_urls)
    @rental_options_and_urls

  end

  def scrape_listing_page(url)
    @result_hash = {}
    i = 1
    html = open(url)
    doc = Nokogiri::HTML(html)
    doc.css(".result-row .result-info").each do |result|
      url = result.css("a").first.attr("href")
      size = result.css(".housing").text.split
      size.delete("-")
      size = size.join(" ")
      @result_hash[i] = result.css(".result-date").text, result.css(".result-title").text, result.css(".result-price").text, size, result.css(".result-hood").text, url
      i += 1
    end
    @result_hash

  end



end
