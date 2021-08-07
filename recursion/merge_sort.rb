def merge_sort(arr)
  return arr if arr.size < 2 
  
  left_arr = arr.slice(0..arr.size/2-1)
  right_arr = arr.slice(arr.size/2..-1)
  left_arr = merge_sort(left_arr)
  right_arr = merge_sort(right_arr)

  result = []
  
  until left_arr.empty?
    if right_arr.empty?
      result.concat(left_arr)
      break
    else
      result << (left_arr.first < right_arr.first ? left_arr.shift : right_arr.shift)
    end
  end
  result.concat(right_arr) unless right_arr.empty?

  return result
end

p merge_sort([6,0,5,-1,3,-8,4,9,2])