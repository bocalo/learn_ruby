require_relative 'productable.rb'
require_relative 'validation.rb'

class Wagons
  include Productable
  include Validation

  WAGON_TYPES = %i[cargo passenger]

  attr_reader :type
  
  def initialize(type)
    @type = type
    validate!
  end

  def validate!
    unless WAGON_TYPES.include?(@type)
      raise ArgumentError, "Wagon's type must be cargo or passenger" 
    end
  end
end