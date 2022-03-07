module ListingsHelper
    # displays pricing in dollars, from cents
    def format_pricing(price)
        "$#{price/100}"
    end

    # displays brand name rather than the ID
    def format_brand(brand_id)

    end
end
