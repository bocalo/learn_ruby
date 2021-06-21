# frozen_string_literal: true
require_relative 'productable.rb'
require_relative 'instance_counter.rb'
require_relative 'validation.rb'
require_relative 'accessors'

class Station
  include InstanceCounter
  include Validation

  NAME_FORMAT = /^[a-z]{3,}$/i.freeze

  attr_reader :name, :trains

  validate :name, :presence
  
  @@all_stations = []

  def self.all
    @@all_stations
  end

  def self.find(name)
    @@all_stations.find { |el| el if el.name == name }
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@all_stations << self
    register_instance
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

  def each_train(&block)
    @trains.each { |train| block.call(train) if block_given? }
  end

  # protected

  # def validate!
  #   raise ArgumentError, "Name can't be empty. Try again" if name.empty?
  #   raise ArgumentError, 'Name should be at least 3 chars. Try again' if name.length < 3
  #   raise ArgumentError, 'Name has invalid format' if name !~ NAME_FORMAT

  #   raise ArgumentError, 'Станция с таким названием уже существует' if self.class.find(@name)
  # end
end
