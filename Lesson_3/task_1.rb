class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
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

class Route
  attr_reader :first_station, :last_station, :inters

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @inters = []
  end

  def all_stations
    [@first_station, @inters, @last_station].flatten.compact
  end

  def add_station(station)
    @inters << station
  end

  def remove_station(station)
    @inters.delete(station)
  end
end

class Train
  attr_reader :speed, :wagons, :type

  def initialize(number, type = :cargo, wagons = 0)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
    @route = nil
    @station_index = nil
  end

  def set_route(r)
    @route = r
    @station_index = 0
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

  def add_wagon
    @wagons += 1 if @speed.zero?
  end

  def remove_wagons
    @wagons -= 1 if @speed.zero?
  end
end