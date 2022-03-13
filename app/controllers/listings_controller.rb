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

  def show


  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.new(listing_params)
    if @listing.save
      redirect_to @listing, notice: "Listing successfully created"
    else
      pp @listing.errors
      form_vars
      render "new", notice: "Listing not saved, please review and try again"
    end
  end

  def edit
    
  end

  def update
    @listing.update(listing_params)
    if @listing.save
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

  def display_listing
    #To show individual listing item
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

  def form_vars
    @categories = Category.all
    @brands = Brand.all
  end

  def listing_params
    params.require(:listing).permit(:brand_id, :model, :condition, :movement, :case_details, :strap, :year, :price, :description, :picture, :authenticity, :categories)
  end

end
