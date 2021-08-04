Warning[:experimental] = false
require "./my_enumerable.rb"


test = [1, 2, 3]
hashtest = {a: 1, b: 2, c: 3}

# test.my_each { |x| puts x}
# test.my_each_with_index { |x, i| puts "#{i}. #{x}"}
# p test.my_select { |x| x == 2}
# p test.my_all?(Integer)
# p test.my_any?(Integer)
# p test.my_none?(String)
# p test.my_count(2)