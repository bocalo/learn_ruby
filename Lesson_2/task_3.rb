def fibo(max_val)
  fibo = [0, 1]

  loop do
    val = fibo[-1] + fibo[-2]
    break if val >= max_val
    fibo << val
  end
  fibo
end
print fibo(100)