def merge(array)
  array1 = array.slice!(0, array.length / 2)
  array2 = array
  array1 = merge(array1) unless array1.length <= 1
  array2 = merge(array2) unless array2.length <= 1

  # return array1 if array1.length == 1
  # return array2 if array2.length == 1

  new_array = []
  a = 0
  b = 0
  until a == array1.length || b == array2.length do
    if array1[a] < array2[b]
      new_array << array1[a]
      a += 1
    else
      new_array << array2[b]
      b += 1
    end
  end

  if array1[a].nil?
    new_array << array2[b..(array2.length - 1)]
  elsif array2[b].nil?
    new_array << array1[a..(array1.length - 1)]
  end

  # if array.length > 1
  #   array = merge(array)
  # else
  #   array = []
  # end


  # until first_half.empty? || array.empty?
  #   if first_half[0] <= array.flatten[0]
  #     new_array << first_half[0]
  #     first_half.shift
  #     break
  #   else
  #     new_array << array[0]
  #     array.shift
  #   end
  # end

  # new_array << (first_half.empty? ? array : first_half)



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
# 
# 4 1 2 3
# 4 1     2 3
# 4   1       2   3
# 

print merge([3, 1, 4, 2, 2, 2, 1, 3])
