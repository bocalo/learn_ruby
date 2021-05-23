# class Car
#   attr_accessor :color
#   attr_reader :door_title, :number

#   def initialize(number)
#     @number = number
#     @color = 'white'
#   end

#   def beep
#     puts 'beep beep'
#   end

#   def change_door_title(driver)
#     @door_title = driver.name if driver.cars.include?(self)
#   end
# end

# class Driver
#   attr_reader :name, :cars

#   def initialize(name)
#     @name = name
#     @cars = []
#   end

#   def buy_car(car)
#     @cars << car
#     car.change_door_title(self)
#   end
# end

require_relative 'Lesson_3/task_1.rb'

st1 = Station.new('May', :cargo)
pp st1.add_train(:cargo)
pp st1
pp st1.type_trains(:cargo)


  