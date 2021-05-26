class PassengerTrain < Train
   attr_reader :passenger, :wagons
   
  def initialize(type = :passenger, wagons = [])
    @type = type
    @wagons = wagons
  end
end