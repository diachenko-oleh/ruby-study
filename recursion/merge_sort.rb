def merge_sort(arr)
  return arr if arr.length <= 1
  
  middle = arr.length/2
  left_arr  = merge_sort(arr[0...middle])
  right_arr = merge_sort(arr[middle...arr.length])
  
  final_arr =[]
  until left_arr.empty? || right_arr.empty?
    if left_arr.first <= right_arr.first
      final_arr << left_arr.shift
    else
      final_arr << right_arr.shift
    end
  end
  return final_arr+ left_arr + right_arr
end

  p "---"
  p merge_sort([]) #→ []
  p "---"
  p merge_sort([73]) #→ [73]
  p "---"
  p merge_sort([1, 2, 3, 4, 5]) #→ [1, 2, 3, 4, 5]
  p "---"
  p merge_sort([3, 2, 1, 13, 8, 5, 0, 1]) #→ [0, 1, 1, 2, 3, 5, 8, 13]
  p "---"
  p merge_sort([105, 79, 100, 110]) #→ [79, 100, 105, 110]
  p "---"