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
    @inters.join(' ')
  end

  def remove_station(station)
    @inters.delete(station)
  end
end