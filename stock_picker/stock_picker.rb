def stock_picker(stock_prices)
	if stock_prices.class != Array
		raise TypeError.new "Expected an array not #{stock_prices.class}"
	end

	if stock_prices.length <= 1
		puts "Not enough days to buy and sell."
		return []
	end
	# Initialize best based on first day profit
	overall_best = stock_prices[1] - stock_prices[0]
	best_indices = [0, 1]
	
	stock_prices.each_with_index do |buy_price, day|
		# Check to which sell day would yield most
		# profit moving forward.
		max_sell_info = stock_prices[day..-1].each_with_index.max

		# Reached end of loop i.e stock_prices[-1..-1].max == nil
		if max_sell_info == nil
			continue
		end

		# Split max_sell_info into its components
		max_sell_price, max_sell_day = max_sell_info
		day_best = max_sell_price - buy_price

		if day_best > overall_best
			overall_best = day_best
			# Add day to account for indices in sell info starting at 0
			best_indices = [day, max_sell_day + day]
		end
    end

	return best_indices
end
