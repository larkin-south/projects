def stock_picker(stock_values)
    stock_buy_matrix = stock_buy(stock_values)
    stock_sell_matrix = stock_sell(stock_buy_matrix).compact
    # puts stock_buy_matrix
    # puts stock_sell_matrix
    sell = []
    sell << stock_sell_matrix.reduce() { |acc, item| item > acc ? acc = item : acc }
    sell
end

def stock_buy(stock_values)
    stock_matrix = {}
    stock_values.each_with_index do |value, index|
        remaining_stock = stock_values.slice(index + 1, stock_values.count)
        capital_gains = []
        remaining_stock.each do |num|
            capital_gains << num - value
        end
        stock_matrix[index] = capital_gains
    end
    stock_matrix
end

def stock_sell(stock_buy_matrix)
    best_gains = []
    stock_buy_matrix.each_with_index do |value, index|
        best_gains << stock_buy_matrix[index].reduce() do |acc, item| 
            item > acc ? acc = item : acc
        end
    end
    best_gains
end



puts stock_picker([17,3,6,9,15,8,6,1,10])