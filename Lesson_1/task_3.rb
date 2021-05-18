puts "Tell me the length of one side of triangle"
a = gets.chomp.to_i
puts "Tell me the length of another side of triangle"
b = gets.chomp.to_i
puts "Tell me the length of the last side of triangle"
c = gets.chomp.to_i

x, y, z = [a, b, c].sort

if (z ** 2 == x ** 2 + y ** 2)
  puts "The right triangle"
elsif (x == y) && (x == z) && (z == y)
  puts "The equilateral triangle"
elsif x == y
  puts "The isosceles triangle"
else
  puts "That is triangle"
end
