require_relative 'productable.rb'
require_relative 'validation.rb'

class Wagons
  include Productable
  include Validation

  WAGON_TYPES = %i[cargo passenger]

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
    unless WAGON_TYPES.include?(@type)
      raise ArgumentError, "Wagon's type must be cargo or passenger" 
    end
    raise ArgumentError, "Wagon's space can't be nil" if self.space <= 0
  end
end