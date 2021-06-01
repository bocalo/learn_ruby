class CargoTrain < Train
  
  attr_reader :number, :type, :wagons, :speed

  def initialize(number, type = :cargo, speed = 0)
    @number = number
    @type = type
    @wagons = wagons
    @speed = speed
  end
end