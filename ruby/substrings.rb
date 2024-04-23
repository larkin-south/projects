def substrings(string, dictionary)
    dictionary.reduce(Hash.new) do |acc, item| 
        if string.include?(item)
            if acc[item].nil? ? acc[item] = 1 : acc[item] += 1
            end
        end
        acc
    end
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings("below", dictionary)
# puts substrings("Howdy partner, sit down! How's it going?", dictionary)