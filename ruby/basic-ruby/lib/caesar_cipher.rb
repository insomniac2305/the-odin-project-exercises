class CaesarCipher 

  def caesar_cipher(message, shift_by)
    alphabet = %w[a b c d e f g h i j k l m n o p q r s t u
                  v w x y z]
    shifted_alphabet = %w[a b c d e f g h i j k l m n o p q r s
                          t u v w x y z]
      
    while shift_by < 0 do
      shift_by += 26
    end 

    shift_by.times do
      shifted_alphabet.push(shifted_alphabet.shift)
    end
  
    message_array = message.split('')
    message_array.map! do |char|
      char_is_upcase = char.upcase === char
      char = char.downcase
      index = alphabet.find_index(char)
      char = index ? shifted_alphabet[index] : char
      char = char_is_upcase ? char.upcase : char
    end
    message_array.join
  end

end
