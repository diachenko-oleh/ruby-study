class Code
  attr_accessor :code
  def initialize(code)
    @code = code
  end
  
  def self.get_code
    return (0..9).to_a.sample(4)#.join
  end

  def check_code(guess)
    answer = [-1,-1,-1,-1]
    for i in 0..3
      if guess[i].to_i == @code[i]
        answer[i] = 1
      elsif @code.include?(guess[i].to_i)
        answer[i] = 0
      end
    end
    return answer
  end

end