def caesar_cipher(input,shift)
    input.each_char.with_index do |char,i|
        char_code = char.ord
        new_char_code = char_code+shift
        if((65..90).cover?(char_code))
            char_code = new_char_code>91?new_char_code-26: new_char_code
        elsif((97..122).cover?(char_code))
            char_code = new_char_code>122?new_char_code-26: new_char_code
        end
        
        input[i]=char_code.chr
    end
end

p caesar_cipher("What a string!", 5)
