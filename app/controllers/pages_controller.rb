class PagesController < ApplicationController

  def index
    data = Scraper.scrape('https://www.usvotefoundation.org/vote/state-elections/state-voting-laws-requirements.htm')
  end
end
