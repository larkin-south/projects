def bubble_sort(number_list)
    for count in 1..number_list.count
        index_a = 0
        index_b = 1
        while index_b < number_list.count do
            if number_list[index_a] > number_list[index_b]
                larger_number = number_list[index_a]
                number_list[index_a] = number_list[index_b]
                number_list[index_b] = larger_number
            end
            index_a += 1
            index_b += 1
        end
    end
    number_list
end

p bubble_sort([4,3,78,2,0,2])