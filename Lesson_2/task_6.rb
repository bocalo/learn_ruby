basket = {}
total = 0

puts 'Введите стоп, чтобы закончить'

loop do
  puts 'Введите название товара'
  item = gets.chomp
  break if item == 'stop'

  puts 'Введите цену товара'
  price = gets.chomp.to_f

  puts 'Введите количество купленного товара'
  amount = gets.chomp.to_f

  basket[item] = { price => amount }
end

basket.each do |item, price|
  puts "#{item} стоит #{price.keys.first * price.values.first}"
  total += price.keys.first * price.values.first
end

puts "Общая сумма покупок: #{total}"