class Train
  attr_reader :speed, :wagons, :type, :number, :route

  def initialize(number, type = :cargo, wagons)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    @route = nil
    @station_index = nil
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
    @wagons << wagon if @speed.zero? && self.type == wagon.type
  end

  def remove_wagons(wagon)
    @wagons.delete wagon if @speed.zero? && self.type == wagon.type
  end

  def set_route(route)
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
end

