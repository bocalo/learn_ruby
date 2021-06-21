# frozen_string_literal: true

require_relative 'productable.rb'
require_relative 'instance_counter.rb'
require_relative 'validation.rb'

class Train
  include Productable
  include InstanceCounter
  include Accessors
  include Validation

  NUMBER_FORMAT = /^[a-z]{2}-\d{3}$/i.freeze
  #TYPE_FORMAT = /(cargo|passenger)/i.freeze

  attr_reader :speed, :wagons, :type, :number, :route

  
  validate :number, :format, NUMBER_FORMAT

  NUMBER_FORMAT_ERROR = 'Неверный номер'
  NUMBER_FORMAT_EMPTY = 'Пустой номер'

  @@trains = []

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    @@trains << self
    register_instance
    validate!
  end

  def self.find_train(number)
    @@trains.find { |el| el.number == number }
  end

  def speed_up(number)
    @speed += number
  end

  def breake(number)
    @speed -= number
  end

  def stop
    @speed = 0
  end

  def run(number)
    @speed = number
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero? && type == wagon.type
  end

  def remove_wagons(wagon)
    @wagons.delete wagon if @speed.zero? && type == wagon.type
  end

  def define_route(route)
    @route = route
    @station_index = 0
    current_station.take_train(self)
  end

  def move_forward
    return unless @route && next_station

    current_station.send_train(self)
    @station_index += 1
    current_station.take_train(self)
  end

  def move_back
    return unless @route && prev_station

    current_station.send_train(self)
    @station_index -= 1
    current_station.take_train(self)
  end

  def current_station
    @route.all_stations[@station_index]
  end

  def next_station
    return unless @route

    @route.all_stations[@station_index + 1]
  end

  def prev_station
    return unless @route
    return if @station_index < 1

    @route.all_stations[@station_index - 1]
  end

  def each_wagon(&block)
    @wagons.each_with_index { |wagon, index| block.call(wagon, index) if block_given? }
  end

  protected

  def validate!
    raise NUMBER_FORMAT_ERROR if number !~ NUMBER_FORMAT
    raise NUMBER_FORMAT_EMPTY if number.empty?
  end
end
