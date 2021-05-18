puts 'Введите коэффициент a'
a = gets.chomp.to_i

puts 'Введите коэффициент b'
b = gets.chomp.to_i

puts 'Введите коэффициент c'
c = gets.chomp.to_i

discrim = b**2 - 4 * a * c

if discrim > 0
  q = Math.sqrt(discrim)
  x1 = (-b + q)/2 * a
  x2 = (-b - q)/2 * a
  puts discrim.to_i
  puts x1
  puts x2
elsif discrim == 0
  x = -b/(2 * a)
  puts discrim.to_i
  puts x
else
  puts 'Корней нет'
end
