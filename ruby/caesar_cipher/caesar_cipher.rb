def caesar_cipher(string, shift)
    split = string.split("")
    array = split.map { |value| value.count("a-zA-Z") > 0 ? value.ord : value }
    cipher = array.map do |value|
        if value.is_a? Integer
            if (value.between?(97, 122))
                value += shift
                if (value > 122)
                    value = (value - 122) + 96
                elsif (value < 97)
                    value = 123 - (97 - value)
                else
                    value
                end
            else (value.between?(65, 90))
                value += shift
                if (value > 90)
                    value = (value - 90) + 64
                elsif (value < 65)
                    value = 91 - (65 - value)
                else value
                end
            end
        else
            value
        end
    end
    cipher.join(" ")
end

puts caesar_cipher("I've been testing this for quite a while now.", 18)