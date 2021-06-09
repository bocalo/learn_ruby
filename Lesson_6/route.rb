require_relative 'instance_counter.rb'
require_relative 'validation.rb'

class Route
  include InstanceCounter
  include Validation

  attr_reader :first_station, :last_station, :inters

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @inters = []
    register_instance 
    validate!
  end

  def all_stations
    [@first_station, @inters, @last_station].flatten.compact
  end

  def add_station(station)
    @inters << station
    @inters.join(' ')
  end

  def remove_station(station)
    @inters.delete(station)
  end

  def validate!
    raise ArgumentError, 'The station can not be nil' if self.first_station.nil? ||
     self.last_station.nil?
    raise ArgumentError, 'You need two stations to create the route' if [@first_station, @last_station].length < 2
    raise ArgumentError, 'The stations need to have different names' if self.first_station.name == self.last_station.name 
  end
end