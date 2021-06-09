class PassengerTrain < Train
  attr_reader :number, :type, :wagons

  def initialize(number, type = :passenger)
    super
  end
end