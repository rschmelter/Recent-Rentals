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






end
