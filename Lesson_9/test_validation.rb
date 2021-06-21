require_relative 'validation'
require_relative 'station'

class TestValidation
  include Validation
  attr_accessor :name, :number, :station

  validate :name, :presence
  validate :number, :format, /^[a-z]{3,}$/i
end

class TestValidation
  include Validation
  attr_accessor :name, :number, :station

  
  validate :number, :format, /^{1,3}/
end

if __FILE__ == $PROGRAMM_NAME
  t = TestValidation.new
  # t.name = 'test'
  # t.number = /^[a-z]{3,}$/i
  # t.station = Station.new("RT1")
  # t.station1 = Station.new("RT2")
  # t.route = Route.new('RT1', 'RT2')
  #puts !t.valid? ? "OK" : "BAD"

  t.name = 'test'
  t.number = 'A-Z'
  t.station = Class.new
  puts !t.valid? ? "OK" : "BAD"

  # t.name = 'test'
  # t.number = 'A'
  # t.station = Station.new(3, "RT1")
  # puts !t.valid? ? "OK" : "BAD"

  # t2 = TestValidation2.new
  # t2.number = 'A-Z'
  # puts t2.valid? ? "OK" : "BAD"
  # t2.number = 'B'
  # puts !t2.valid? ? "OK" : "BAD"
end

