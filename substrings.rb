dictionary = ["below","down","GO","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(input,dictionary)
    input.downcase!
    answer =  Hash.new(0)
    dictionary.each do |word|
        overlap = input.scan(word.downcase).length
        if overlap>0
            answer[word] = overlap
        end
    end
    
    return answer

end

p substrings("Below",dictionary)


