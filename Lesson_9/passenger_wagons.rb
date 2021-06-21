# frozen_string_literal: true

require_relative 'wagons.rb'

class PassengerWagons < Wagons
  attr_reader :space, :occupied_space

  def initialize(space = 50)
    @space = space.to_i
    @occupied_space = 0
    super(:passenger)
  end

  def take_seats
    @occupied_space += 1
  end
end
