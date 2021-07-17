require "./Code.rb"

class ComputerPlayer

  def self.select_code
    code = Code.new
    4.times {code.numbers.push(rand(1..6))}
    return code
  end

end