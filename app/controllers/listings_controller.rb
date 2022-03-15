class ListingsController < ApplicationController
  # If user not signed in can only view the index and show
  before_action :authenticate_user!, except: [:index, :show]
  before_action :display_listing, only: [:show, :edit, :update, :destroy]
  # creates authorisation so only the user owner can edit/update/destroy their listings
  before_action :authorize_user, only: [:edit, :update, :destroy]
  before_action :form_vars, only: [:index, :new, :edit]

  def index
    #To show all listings
    @listings = Listing.all
  end

  # takes details of specific (selected) listing and creates a stripe checkout session
  def show

  end

  def new
    @listing = Listing.new
  end

  # Creates a listing through a (current) user, redirects accordingly if created successfully or not
  # def create
  #   @listing = current_user.listings.new(listing_params)
  #   if @listing.save
  #     # Creates related category listings in listings_categories table
  #     params[:listing][:listings_categories].each do |cat|
  #       ListingsCategory.create(listing: @listing, category_id: cat) if cat != ""
  #     end
  #     redirect_to @listing, notice: "Listing successfully created"
  #       # else
  #       #   pp @listing.errors
  #       #   form_vars
  #       #   render "new", notice: "Listing not saved, please review and try again"
  #     # end
  #   end
  # end

  def create
    @listing = current_user.listings.new(listing_params)
     # Creates related category listings in listings_categories table
    if @listing.save
      params[:listing][:listings_categories].each do |cat|
        ListingsCategory.create(listing: @listing, category_id: cat) if cat != ""
      end
      redirect_to @listing, notice: "Listing successfully created"
    else
      pp "**********"
      pp @listing.errors
      pp "**********"
      form_vars
      render "new", notice: "Listing not saved, please review and try again"
    end
  end

  def edit
    
  end

  def update
    @listing.update(listing_params)
    if @listing.save
      params[:listing][:listings_categories].each do |cat|
        ListingsCategory.create(listing: @listing, category_id: cat) if cat != ""
      end
      pp "**********"
      pp @listing
      pp "**********"
      redirect_to @listing, notice: "Listing successfully updated"
    else
      pp @listing.errors
      form_vars
      render "new", notice: "Listing not saved, please review and try again"
    end
  end

  def destroy
    @listing.destroy
    redirect_to listings_path, notice: "Listing successfully deleted"
    end

  private

  # Allows functions to show individual listing/brand item
  def display_listing
    @listing = Listing.find(params[:id])
    @brand = Brand.find(@listing.brand_id)
  end

  def authorize_user
    if @listing.user_id != current_user.id
      redirect_to listings_path, alert: "You don't have the required authorisation"
    end
  end

  def brand_names
    @brands = Brand.all
  end

  # Loads all the items in each related variable class
  def form_vars
    @categories = Category.all
    @brands = Brand.all
  end

  # provides the paramaters that can be created/updated/modified
  def listing_params
    params.require(:listing).permit(:brand_id, :model, :condition, :movement, :case_details, :strap, :year, :price, :description, :picture, :authenticity, listings_categories: [:category_id])
  end

end
