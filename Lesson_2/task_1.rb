
months = { 'January' => 31, 'Febreary' => 28, 'March' => 31, 'April' => 30, 'May' => 31, 'June' => 30, 'July' => 31, 'August' => 31, 'September' => 30, 'October' => 31, 'November' => 30, 'December' => 30 }

# arr = months.select { |el| months[el] == 30 }
# arr.keys.join(', ')


months.each do |month, val|
  puts "#{month}" if months[month] == 30
end