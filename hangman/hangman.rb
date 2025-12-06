require_relative 'word'

def check(word,answer,digit)
  word.each_char.with_index do |dgt,i|
    if dgt==digit
      answer[i] = digit
    end
  end
  return answer
end

puts "new game: 1\ncontinue: 2"
ch = gets.chomp
if ch == "1" 
  word = Word.get_word
  p word
  answer = String.new("_" * word.length)
  p answer
  guess = 1
elsif ch == "2"
  File.open("game.txt", "r") do |file|
    content = file.to_a
    answer= content[0].chop
    word = content[1].chop
    guess = content[2].to_i
  end
  p answer
end


loop do
  puts " "
  puts "turn #{guess}"
  puts "enter letter:"
  digit = gets.chomp
  if digit.length != 1
    puts "enter 1 letter per turn"
    next
  end

  answer = check(word,answer,digit)
  puts "result:"
  p answer

  File.open("game.txt", "w") do |file|
    file.puts answer
    file.puts word
    file.puts guess
  end

  if !answer.include?("_")
    puts "you guessed the word"
    File.delete("game.txt")
    break
  end
  guess+= 1

  
end



