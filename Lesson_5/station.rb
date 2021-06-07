require_relative 'instance_counter.rb'

class Station
  include InstanceCounter

  attr_reader :name, :trains
  @@all_stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << self
    register_instance 
  end

  def self.all
    @@all_stations
  end

  def take_train(train)
    @trains << train
  end

  def all_trains
    @trains
  end

  def trains_by_type(type)
    @trains.select { |el| el.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end
end