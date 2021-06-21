# frozen_string_literal: true

require_relative 'wagons.rb'

class CargoWagons < Wagons
  attr_reader :space, :occupied_space

  def initialize(space = 138)
    super(:cargo)
    @space = space.to_i
    @occupied_space = 0
  end

  def take_volume(place)
    @occupied_space += place
  end
end
