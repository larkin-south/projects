def caesar_cipher(string, shift)
  split = string.chars
  p split
  array = split.map { |value| ord_values(value) }
  cipher = array.map do |value|
    (value.instance_of? Integer) ? shifts(value, shift) : value
  end
  cipher.join(" ")
end

def ord_values(item)
  item.count("a-zA-Z").positive? ? item.ord : item
end

def shifts(item, shift)
  if item.between?(97, 122)
    item += shift
    if item > 122
      (item - 122) + 96
    elsif item < 97
      123 - (97 - item)
    else
      item
    end
  else
    item.between?(65, 90)
    item += shift
    if item > 90
      (item - 90) + 64
    elsif item < 65
      91 - (65 - item)
    else
      item
    end
  end
  item
end

puts caesar_cipher("I've been testing this for quite a while now.", 18)
