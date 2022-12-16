def fibs(n)
  fibonacci_numbers = []
  i = 1
  sum = 1
  sum_prev = 1
  while i <= n
    fib = sum + sum_prev
    fib = 1 if i.between?(1, 2)
    fibonacci_numbers << fib
    sum_prev = sum
    sum = fib
    i += 1
  end
  return fibonacci_numbers
end

# p fibs(10)
# p fibs(0)
# p fibs(1)
# p fibs(2)

def fibs_rec(n)
  return [] if n == 0
  return [1] if n <= 1
  return [1, 1] if n == 2
  last_fib = fibs_rec(n - 1)
  return last_fib << last_fib[-1] + last_fib[-2]
end

# p fibs_rec(10)
# p fibs_rec(0)
# p fibs_rec(1)
# p fibs_rec(2)