def merge_sort(array)
  return array if array.length <= 1

  left = array.slice!(0, array.length / 2)
  right = array
  left = merge_sort(left)
  right = merge_sort(right)

  new_array = []
  a = 0
  b = 0

  until left[a].nil? || right[b].nil?
    if left[a] < right[b]
      new_array << left[a]
      a += 1
      new_array << right[b..right.length] if left[a].nil?
    else
      new_array << right[b]
      b += 1
      new_array << left[a..left.length] if right[b].nil?
    end
  end

  new_array.flatten
end
