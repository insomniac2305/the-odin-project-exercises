def bubble_sort(array)

  is_sorted = false
  iteration = 1

  until is_sorted

    is_sorted = true

    for index in 1..array.length-iteration do
      a = array[index-1]
      b = array[index]
      if a > b
        array[index-1] = b
        array[index] = a
        is_sorted = false
      end
    end    

    iteration += 1
  end

  return array

end

p bubble_sort([4,3,78,2,0,2])