def fibs(n)
  if n<=1
    return [0]
  else
    arr = [0,1]
    (n-2).times do
      arr<<(arr[-1]+arr[-2])
    end
    return arr
  end
end


def fibs_rec(n)
  return [0] if n<=1
  return [0,1] if n==2

  return fibs_rec(n-1)<<fibs_rec(n-1)[-1]+fibs_rec(n-2)[-1]
end


p fibs(8)
p fibs_rec(8)