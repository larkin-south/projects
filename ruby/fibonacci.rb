def fibonacci_iteration(num)
  array = [0, 1]
  i = 0
  until array.length == num do
    array << (array[i] + array[i + 1])
    i += 1
  end
  p array
end

def fibonacci_recursion(num, array = [0, 1])
  return p array if array.length == num

  array << array[-2] + array[-1]
  fibonacci_recursion(num, array)
end

fibonacci_iteration(20)
fibonacci_recursion(20)
