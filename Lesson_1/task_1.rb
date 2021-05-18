puts "What's your name?"
name = gets.chomp
puts "How tall are you?"
height = gets.chomp
weight = (height.to_i - 110) * 1.15
if weight < 0
  puts "#{name}, your weight is already optimal"
else
  puts "#{name}, your weight is #{weight} kg"
end
