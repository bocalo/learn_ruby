require_relative 'accessors'

class Test
  include Accessors

  attr_accessors_with_history :a, :b, :c
end

t = Test.new
t.a = 1
t.b = 10
t.c = 50

puts t.a_history.inspect
puts t.b_history.inspect
puts t.c_history.inspect