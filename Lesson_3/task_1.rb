# К сожалению сам все написать не смог, но попытался разобраться в чужом коде
# Я проверял все в pry, поэтому буду вставлять код оттуда.

# В классе Station особых проблем не было, за исключением метода trains_by_type(type)(строка 22)

# Чтобы его проверить, я инициализирую класс Station и класс Train(именно там появляется type)

# И вот, что получается

# pry(main)> st = Station.new('May')
# #<Station:0x000056269ce5d698 @name="May", @trains=[]>
# [72] pry(main)> st.take_train(33)
# [
#     [0] 33
# ]
# [73] pry(main)> st.take_train(44)
# [
#     [0] 33,
#     [1] 44
# ]
# [74] pry(main)> st.take_train(55)
# [
#     [0] 33,
#     [1] 44,
#     [2] 55
# ]
# [75] pry(main)> st.send_train(44)
# 44
# [76] pry(main)> st.all_trains
# [
#     [0] 33,
#     [1] 55
# ]
# [77] pry(main)> train = Train.new('100')
# #<Train:0x000056269cf7a800 @number="100", @type=:cargo, @wagons=0, @speed=0, @route=[], @station_index=0>
# [78] pry(main)> 
# [78] pry(main)> st.trains_by_type(:cargo)
# NoMethodError: undefined method `type' for 33:Integer
# from task_1.rb:20:in `block in trains_by_type'

# Я пробовал строку и символ вместо 33:Integer, но не помогло. А почему не работает el.type в этом случае? Он же стоит в Train по умолчанию - def initialize(number, type = :cargo, wagons = 0)


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

# В классе Train не могу добраться до методов, начиная с метода set_route(r) до метода move_back. То есть те методы, в к-рых присутствуют элементы других классов. Может, я их неправильно вызываю. Вроде бы все понятно, но надо проверить, а проверить не могу. 

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

# # pry для Train

# st = Station.new('May')
# #<Station:0x000055ec8341a4e0 @name="May", @trains=[]>
# [3] pry(main)> st.take_train(33)
# [
#     [0] 33
# ]
# [4] pry(main)> st.take_train(44)
# [
#     [0] 33,
#     [1] 44
# ]
# [5] pry(main)> st.take_train(55)
# [
#     [0] 33,
#     [1] 44,
#     [2] 55
# ]
# [6] pry(main)> st.all_trains
# [
#     [0] 33,
#     [1] 44,
#     [2] 55
# ]
# [7] pry(main)> 
# [7] pry(main)> rt = Route.new('cheese', 'meet')
# #<Route:0x000055ec83517d98 @first_station="cheese", @last_station="meet", @inters=[]>
# [8] pry(main)> rt.add('apple')
# [
#     [0] "apple"
# ]
# [9] pry(main)> rt.add('pear')
# [
#     [0] "apple",
#     [1] "pear"
# ]
# [10] pry(main)> rt.add('grape')
# [
#     [0] "apple",
#     [1] "pear",
#     [2] "grape"
# ]
# [11] pry(main)> rt.all_stations
# [
#     [0] "cheese",
#     [1] "apple",
#     [2] "pear",
#     [3] "grape",
#     [4] "meet"
# ]
# [12] pry(main)> 
# [12] pry(main)> train = Train.new('100')
# #<Train:0x000055ec83613558 @number="100", @type=:cargo, @wagons=0, @speed=0, @route=nil, @station_index=nil>
# [13] pry(main)> train.set_route(rt)
# NoMethodError: undefined method `take_train' for "cheese":String
# from task_1.rb:108:in `set_route'

# То есть не определяется метод `take_train' для current_station

# current_station.take_train(self)