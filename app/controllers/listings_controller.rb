class ListingsController < ApplicationController
  def index
    #To show all listings
    @listings = Listing.all
  end

  def show
    #To show individual listing item
  end
end
