class CargoTrain < Train
  attr_reader :number, :type, :wagons

  def initialize(number, type = :cargo)
    @number = number
    @type = type
    @wagons = wagons
  end
end