class CargoTrain < Train
  attr_reader :number, :type, :wagons

  def initialize(number)
    super(number, type = :cargo)
  end
end

