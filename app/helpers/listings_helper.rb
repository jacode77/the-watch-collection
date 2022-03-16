module ListingsHelper
    # displays pricing in dollars, from cents
    def format_pricing(price)
        "$#{price/100}"
    end

end
