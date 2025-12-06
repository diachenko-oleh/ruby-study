require_relative 'lib/code'

def guess_code(code)
    tries = 10
    win = false
    while tries>0
      answer = [-1,-1,-1,-1]
      puts "Для відгадки залишилось #{tries} спроб"
      puts "Введіть відгадку:"
      guess = gets.chomp
      guess_arr = guess.chars
      answer = code.check_code(guess_arr)
      p answer
      if answer.sum == 4
        win = true
        puts "Код відгадано!"
        break
      end
      tries-=1
    end
    if !win
      puts "Код не відгадано. Код був: #{code.join}"
    end
end

def make_code
  tries = 10
  win = false
  puts "Введіть код:"
  code = gets.chomp
  code_arr = code.chars

  found_nums =["0","1","2","3","4","5","6","7","8","9"]
  known_nums =[]
  banned_nums =[]
  known_position={}
  while tries>0
    new_guess = Array.new(4)
    known_position.each do |key, value|
      new_guess[key] = value
    end

    if known_nums.any?
      for i in 0..3
        if new_guess[i]==nil
          val = known_nums.pop
          new_guess[i]=val unless new_guess.include?(val)
        else
          next
        end
      end
    end
   
    if found_nums.any?
      for i in 0..3
        if new_guess[i]==nil
          val = found_nums.pop
          new_guess[i] = val unless new_guess.include?(val)
        else
          next
        end
      end
    end
    
    answer = [-1,-1,-1,-1]
    for i in 0..3
      if new_guess[i] == code_arr[i]
        answer[i] = 1
      elsif code_arr.include?(new_guess[i])
        answer[i] = 0
      end
    end

    for i in 0..3
      if answer[i] == -1
        banned_nums.push(new_guess[i])
        found_nums.delete(new_guess[i])
      elsif answer[i]==0
        known_nums.push(new_guess[i]) unless known_nums.include?(new_guess[i])
      elsif answer[i]==1
        known_position[i] = new_guess[i]
      end
    end

    if new_guess == code_arr
      win = true
      puts "Код відгадано!"
      break          
    end
    tries-=1
  end
  if !win
      puts "Код не відгадано."
  end
end

puts "Оберіть роль:\n1 - вгадати код\n2 - загадати код"
choice = gets.chomp
case choice
when "1"
  code = Code.new(Code.get_code)
  guess_code(code)
when "2"
  make_code
end

