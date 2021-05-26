require_relative "station"
require_relative "route"
require_relative "train"
require_relative "cargo_train"
require_relative "passenger_train"
require_relative "wagons"
require_relative "passenger_wagons"
require_relative "cargo_wagons"


pp st1 = Station.new('May')
pp st2 = Station.new('June')
pp st3 = Station.new('July')
pp st4 = Station.new('April')

pp rt1 = Route.new(st1, st4)
pp rt2 = Route.new(st2, st3)


pp tr1 = Train.new('100')
pp tr2 = Train.new('200')
pp tr3 = Train.new('300')

pp ct1 = CargoTrain.new
pp ct1.add_wagon(wg1)

pp pt1 = PassengerTrain.new

pp wg1 = Wagons.new(:cargo)
pp wg2 = Wagons.new(:passenger)

pp cw1 = CargoWagons.new




