class PaymentsController < ApplicationController
  # Avoids displaying authenticity token in transation
  skip_before_action :verify_authenticity_token, only: [:webhook]

  def success
    @order = Order.find_by(listing_id: params[:id])
    @brand = Brand.find(@listing.brand_id)
  end

  # Only runs when transaction successfully processed. Provides payment data from stripe & verifies signing secret to make transaction more secure
  def webhook
    # Verifies each event that hits our webhook endpoint and is done securely - Checks if we got an error when checking the secret and returns a message
    begin
      payload = request.raw_post
      header = request.headers["HTTP_STRIPE_SIGNATURE"]
      secret = Rails.application.credentials.dig(:stripe, :webhook_secret)
      event = Stripe::Webhook.construct_event(payload, header, secret)
    rescue Stripe::SignatureVerificationError => e
      render json: {error: "Unauthorised"}, status: 401
      return
    rescue JSON::ParserError => e
      render json: {error: "Bad request"}, status: 400
      return
    end


    # Once secret is verified, the following will run
    payment_intent_id = event.data.object.payment_intent
    payment = Stripe::PaymentIntent.retrieve(payment_intent_id)
    listing_id = payment.metadata.listing_id
    buyer_id = payment.metadata.user_id
    pp payment.charges.data[0].receipt_url
    @listing = Listing.find(listing_id)
    @listing.update(sold: true)

    #
  end

  # Setup for transactions tracking, tracks in orders table
  Order.create(listing_id: listing_id, buyer_id: user_id, seller_id: @listing.user_id, payment_id: payment_intent_id, receipt_url: payment.charges.data[0].receipt_url)
end
