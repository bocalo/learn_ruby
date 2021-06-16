# frozen_string_literal: true

class CargoTrain < Train
  attr_reader :number, :type, :wagons

  def initialize(number)
    super(number, type = :cargo)
  end

  # def initialize(number)
  #   super(number)
  # end
end
