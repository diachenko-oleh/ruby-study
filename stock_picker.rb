def stock_picker(stock)
    if(stock.length<2)
      return "error"
    end
    best_price = 0
    best_days = Array.new(2)
    for i in 0..stock.length-2
      for j in i..stock.length-1
        local_price = stock[j]-stock[i]
        if (local_price>best_price)
          best_price=local_price
          best_days = [i,j]
        end
      end
    end
    if(best_price==0)
      puts "do not buy"
    else
      puts "buy on day #{best_days[0]} and sell on day #{best_days[1]}. you will make #{best_price}$"
    end        

end

puts stock_picker([17,3,6,9,15,8,6,1,10])
