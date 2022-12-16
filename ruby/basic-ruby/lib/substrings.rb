def substrings(sentence, dictionary)
  result = Hash.new(0)

  dictionary.each do |entry|
    working_string = sentence.upcase
    while (index_of_entry = working_string.index(entry.upcase))
      result[entry] += 1
      working_string = working_string[index_of_entry + entry.length..working_string.length]
    end
  end

  result
end

dictionary = %w[below down go going horn how howdy it i low own part partner sit]
puts substrings("Howdy partner, sit down! How's it going?", dictionary)
