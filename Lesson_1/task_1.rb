puts 'What is your name?'
name = gets.chomp
puts 'How tall are you?'
height = gets.chomp.to_i
weight = (height - 110) * 1.15
if weight < 0
  puts "#{name}, your weight is already optimal"
else
  puts "#{name}, your weight is #{weight} kg"
end
