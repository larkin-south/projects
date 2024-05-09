def merge(array)
  first_half = array.slice!(0, array.length / 2)
  if first_half.length > 1
    new_array = merge(first_half)
  else
    new_array = []
  end

  if array.length > 1
    array = merge(array)
  else
    array = []
  end


  until first_half.empty? || array.empty?
    if first_half[0] <= array.flatten[0]
      new_array << first_half[0]
      first_half.shift
      break
    else
      new_array << array[0]
      array.shift
    end
  end

  new_array << (first_half.empty? ? array : first_half)



  new_array

end



# split array in half
# call function to split that half into halves UNLESS lenght is 1

# array of 2 values
# if length is greater than 1
#   split in half
#   compare first of each and add to new array in sorted order
# else
#   return value
# end

print merge([3, 1, 4, 2, 2, 2, 1, 3])
