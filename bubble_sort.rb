def bubble_sort(array)  
  is_sorted = false
  iteration = 1

  until is_sorted
    is_sorted = true
    (1..array.length - iteration).each do |index|
      a = array[index - 1]
      b = array[index]
      next unless a > b

      array[index - 1] = b
      array[index] = a
      is_sorted = false
    end
    iteration += 1
  end

  array
end

p bubble_sort([4, 3, 78, 2, 0, 2])
