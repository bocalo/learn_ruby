require_relative "station"
require_relative "route"
require_relative "train"
require_relative "cargo_train"
require_relative "passenger_train"
require_relative "wagons"
require_relative "passenger_wagons"
require_relative "cargo_wagons"


st1 = Station.new('May')
puts "You are on the station #{st1.name} now." 
puts

st2 = Station.new('June')
st3 = Station.new('July')
st4 = Station.new('April')
st5 = Station.new('March')

rt1 = Route.new(st1, st5)
rt1.add_station(st2)
rt1.add_station(st3)
rt1.add_station(st4)
rt1.all_stations
puts
puts "You can see the list of all stations #{rt1.all_stations}"
puts
puts "Your train is going from station #{rt1.first_station.name} to station #{rt1.last_station.name} tomorrow."
puts "We have added station #{st3.name} and the station #{st4.name} on the route."
puts
rt1.remove_station(st3)
puts "We need to remove station #{st3.name}"
rt2 = Route.new(st2, st3)
puts "There is train with route from #{rt1.first_station.name} to #{rt1.last_station.name} on the station through #{st4.name}" 


tr1 = Train.new('100')
puts
puts "You go on the train number #{tr1.number} through 1 hour."
puts
tr2 = Train.new('200')
tr3 = Train.new('300')

st1.take_train(tr1)
st1.take_train(tr2)
st1.take_train(tr3)
st1.all_trains
puts "You can see the list of all trains: #{st1.all_trains} on the station."

tr1.set_route(rt1)
puts "You can set route #{rt1}"
puts
tr1.move_forward
puts "Your train move_forward #{tr1.move_forward}"
puts
tr1.move_back
puts "Your train move_back #{tr1.move_back}"

# pp ct1 = CargoTrain.new
# pp ct1.add_wagon(wg1)

# pp pt1 = PassengerTrain.new

# pp wg1 = Wagons.new(:cargo)
# pp wg2 = Wagons.new(:passenger)

# pp cw1 = CargoWagons.new




