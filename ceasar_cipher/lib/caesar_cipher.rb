class CaesarCipher 
  def caesar_cipher(input, shift)
    answer = input
    input.each_char.with_index do |char, i|
      char_code = char.ord
      new_char_code = char_code + shift
      if (65..90).cover?(char_code)
        char_code = new_char_code > 91 ? new_char_code - 26 : new_char_code
      elsif (97..122).cover?(char_code)
        char_code = new_char_code > 122 ? new_char_code - 26 : new_char_code
      end

      answer[i] = char_code.chr
    end
  end
end

c_c = CaesarCipher.new()
p c_c.caesar_cipher('What a string!', 5)



