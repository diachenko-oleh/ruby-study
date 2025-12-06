class Word 
    def self.get_word
      arr =[]
      File.open("words.txt", "r") do |file|
        arr = file.to_a
      end

      loop do
        rand_ind = rand(0..arr.length)
        if arr[rand_ind].length>5 && arr[rand_ind].length<12
          word = arr[rand_ind].chop
          return word
        else
          arr.delete(rand_ind)
        end
      end
    end

end