# frozen_string_literal: true

class PassengerTrain < Train
  # attr_reader :number, :type, :wagons

  # def initialize(number)
  #   super(number)
  # end

  def initialize(number)
    super(number, :passenger)
  end
end
