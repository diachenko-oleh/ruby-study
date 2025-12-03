def bubble_sort(list)
  for i in 0..list.length-1
    for j in 0..list.length-1
      if list[i]<list[j]
        temp = list[i]
        list[i]=list[j]
        list[j]=temp
      end
    end
  end
  print list
end

puts bubble_sort([4,3,78,2,0,2])