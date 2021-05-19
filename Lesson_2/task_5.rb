
months_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
res = 0
puts 'Какое сегодня число?'
day = gets.chomp.to_i
res += day

puts 'Какой сейчас месяц по порядку?'
month = gets.chomp.to_i

puts 'Какой год?'
year = gets.chomp.to_i

if year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)
  months_days[1] += 1
end

res += months_days.take(month - 1).sum

puts "Порядковый номер дня: #{res}"