class CargoTrain < Train
  attr_reader :cargo, :wagons

  def initialize(wagons = [])
    @wagons = wagons
  end

  def add_wagon(wagon)
    @wagons += wagon if @speed.zero? && @trains.type == wagon.type
  end
end