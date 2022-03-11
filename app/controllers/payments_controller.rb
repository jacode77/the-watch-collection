class PaymentsController < ApplicationController
  # Avoids displaying authenticity token in transation
  skip_before_action :verify_authenticity_token, only: [:webhook]

  def success
    @listing = Listing.find(params[:id])
    @brand = Brand.find(@listing.brand_id)
  end

  # Only runs when transaction successfully processed. Provides payment data from stripe
  def webhook
    payment_intent_id = params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve(payment_intent_id)
    listing_id = payment.metadata.listing_id
    pp payment.charges.data[0].receipt_url
    @listing = Listing.find(listing_id)
    @listing.update(sold: true)
  end
end
