def stock_picker(prices) 
  profit = 0
  picked_index = []
  prices.each_with_index do |buy_price, buy_index|
    for sell_index in buy_index+1..prices.length-1 do
      current_profit = prices[sell_index] - buy_price
      if current_profit > profit 
        profit = current_profit
        picked_index = [buy_index, sell_index]
      end
    end
  end
  return picked_index
end

stock_prices = [17,3,6,9,15,8,6,1,10]
p stock_picker(stock_prices)