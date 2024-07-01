def stock_picker(stock_values)
    stock_buy_matrix = stock_buy(stock_values)
    stock_sell_matrix = stock_sell(stock_buy_matrix).compact
    sell_value = []
    sell_value << stock_sell_matrix.reduce() { |acc, item| item > acc ? acc = item : acc }
    buy_day = stock_sell_matrix.index(sell_value[0])
    sell_day = stock_buy_matrix[buy_day].index(sell_value[0]) + buy_day

    buy_sell = [buy_day, sell_day]
end

def stock_buy(stock_values)
    stock_matrix = {}
    stock_values.each_with_index do |value, index|
        remaining_stock = stock_values.slice(index, stock_values.count)
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



p stock_picker([17,3,6,9,15,8,6,1,10])