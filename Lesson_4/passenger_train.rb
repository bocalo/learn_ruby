class PassengerTrain < Train
   attr_reader :number, :type, :wagons

  def initialize(number, type = :passenger)
    @number = number
    @type = type
    @wagons = wagons
  end
end