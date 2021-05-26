class PassengerWagons < Wagons
   attr_reader :passenger
  def initialize
    @type = :passenger
  end
end