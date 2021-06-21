# frozen_string_literal: true
require_relative 'train.rb'

class PassengerTrain < Train
  attr_reader :number, :type, :wagons

  def initialize(number)
    super(number, :passenger)
  end
end
