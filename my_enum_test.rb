Warning[:experimental] = false
require "./my_enumerable.rb"


def multiply_els(arr)
  arr.my_inject(:*)
end

test = [2, 4, 5]

test.my_each { |x| puts x}
test.my_each_with_index { |x, i| puts "#{i}. #{x}"}
p test.my_select { |x| x == 2}
p test.my_all?(Integer)
p test.my_any?(Integer)
p test.my_none?(String)
p test.my_count(2)
p test.my_map {|x| x*2}
times2 = -> (x){x*2}
p test.my_map(times2)
p test.my_inject(100, :+)
p multiply_els(test)