# frozen_string_literal: true
require_relative 'train.rb'

class CargoTrain < Train
  attr_reader :number, :type, :wagons

  def initialize(number)
    super(number, :cargo)
  end
end
