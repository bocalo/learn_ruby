# frozen_string_literal: true

require_relative 'productable.rb'
require_relative 'validation.rb'

class Wagons
  include Productable
  include Validation

  WAGON_TYPES = %i[cargo passenger].freeze
  WAGON_TYPES_ERROR = 'Вагон дожен быть грузовым или пассажирским'

  attr_reader :type, :space

  def initialize(type)
    @type = type
    @space = space.to_i
    validate!
  end

  def free_space
    @space - @occupied_space
  end

  def validate!
    raise WAGON_TYPES_ERROR unless WAGON_TYPES.include?(@type)
    # raise StandardError, "Wagon's space can't be nil" if space.zero?
  end
end
