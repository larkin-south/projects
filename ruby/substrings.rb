def substrings(string, dictionary)
    string = string.split(" ")
    letters_only = string.map { |item| item.gsub(/[^a-zA-Z]/, "").downcase }
    dictionary.reduce(Hash.new) do |acc, item| 
        letters_only.each do |word|
            if word.include?(item)
                if acc[item].nil? ? acc[item] = 1 : acc[item] += 1
                end
            end
        end
        acc
    end
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
# puts substrings("below", dictionary)
puts substrings("Howdy partner, sit down! How's it going?", dictionary)