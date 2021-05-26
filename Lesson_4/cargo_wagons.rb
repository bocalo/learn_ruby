class CargoWagons < Wagons
  attr_reader :cargo
  def initialize
    @type = :cargo
  end
end