require "byebug"
require_relative "station"
require_relative "route"
require_relative "train"
require_relative "cargo_train"
require_relative "passenger_train"
require_relative "wagons"
require_relative "passenger_wagons"
require_relative "cargo_wagons"

class Interface
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def main_menu
    loop do
      puts '
      --- Главное меню ---
      Введите номер:
      1. Перейти в меню станций
      2. Перейти в меню поездов
      3. Перейти в меню маршрутов
      4. Выйти из прграммы
      '

      choice = gets.chomp.to_i

      case choice
      when 1
        stations_menu
      when 2
        trains_menu
      when 3
        routes_menu
      when 4
        exit
      else
        puts 'Неправильно набран номер. Попробуйте еще раз.'
      end
    end
  end

  private

  def stations_menu
    loop do
      puts '
      --- Меню станций ---
      Введите номер:
      1. Создать станцию
      2. Просмотреть список всех станций
      3. Вернуться в главное меню
      4. Выйти из прoграммы
      '

      choice = gets.chomp.to_i

      case choice
      when 1
        create_station
      when 2
        stations_list
      when 3
        break
      when 4
        exit
      else
        puts 'Неправильно набран номер. Попробуйте еще раз.'
      end
    end
  end

  def create_station
    print 'Введите название станции: '
    name = gets.chomp.to_s
    puts "#{Station.new(name)}"
    @stations << Station.new(name)
    puts "Станция '#{name}' создана."
  end

  def stations_list
    print 'Список станций: '
    @stations.each { |el| puts el.name }
  end

  def trains_menu
    loop do
      puts "
      --- Меню поездов --- 
      Введите номер:
      1. Создать поезд
      2. Назначить маршрут поезду
      3. Добавить вагон к поезду
      4. Отцепить вагон от поезда
      5. Двигаться до следующей станции
      6. Вернуться на предыдущую станцию
      7. Вернуться в главное меню
      8. Выйти из программы
      "
      choice = gets.chomp.to_i

      case choice
      when 1
        create_train
      when 2
        set_route_to_train
      when 3
        add_wagon
      when 4
        remove_wagon
      when 5
        go_to_next_station
      when 6
        go_to_back_station
      when 7
        break
      when 8
        exit
      else
        puts 'Неправильно набран номер. Попробуйте еще раз.'
      end
    end
  end

  def create_train
    print 'Введите номер поезда: '
    number = gets.chomp

    print "Выберите тип поезда. 1-(грузовой), 2-(пассажирский). Введите число: "
    type = gets.chomp.to_i
    
    if type == 1
      @trains << CargoTrain.new(number)
      puts "#{@trains}"
      puts "Создан грузовой поезд номер #{number}."
    elsif type == 2
      @trains << PassengerTrain.new(number)
      puts "Создан пассажирский поезд номер #{number}."
    else
      puts 'Что-то пошло не так.'

      loop do
        puts 'Придется повторить. Введите число: '
        choice = gets.chomp.to_i
        case choice
          when 1 then create_train
          when 2 then break
          else puts 'Повторите ввод.'
        end 
      end
    end
  end

  def set_route_to_train
    routes_list
    puts 'Выберите маршрут(индекс).'
    idx = gets.chomp.to_i
    route = select_route(idx)
    puts "Маршрут с индексом #{idx} назначен: #{route}"

    trains_list
    puts 'Выберите поезд.'
    title = gets.chomp
    
    train = find_train(title)
    puts "#{train}"

    train.set_route(route)
    puts "#{train.set_route(route)}"
    puts 'Ваш маршрут создан.'
    print 'Этот маршрут проходит через станции: '
    route.all_stations.each { |el| puts el.name }
  end

  def add_wagon
    trains_list
    puts 'Выберите поезд:'
    title = gets.chomp
    train = find_train(title)
    if train.type == :cargo
      train.add_wagon(CargoWagons.new)
    else
      train.add_wagon(PassengerWagons.new)
    end
    puts "Вагон добавлен к поезду #{train.number}."
  end

  def remove_wagon
    trains_list
    puts 'Выберите поезд.'
    title = gets.chomp
    train = find_train(title)
    if train.type == :cargo && train.wagons.size != 0
      train.remove_wagons(CargoWagons.new)
      puts "Отцепляем грузовой вагон. Вагон отцеплен от поезда #{train.number}"
    elsif train.type == :passenger && train.wagons.size != 0
      train.remove_wagons(PassengerWagons.new)
      puts "Отцепляем пассажирский вагон. Вагон отцеплен от поезда #{train.number}"
    else
      puts "Нечего отцеплять."
    end
  end

  def go_to_next_station
    puts 'Назовите номер поезда.'
    title = gets.chomp
    train = find_train(title)
    train_station = train.current_station
    puts "Поезд сейчас стоит на станции #{train_station.name}"
    train.move_forward
    puts "Поезд #{train.number} отправился со станции #{train.current_station.name} на станцию #{train.next_station.name}"
  end

  def go_to_back_station
    puts 'Назовите номер поезда.'
    title = gets.chomp
    train = find_train(title)
    train_station = train.next_station
    puts "Поезд сейчас стоит на станции #{train_station.name}"
    train.move_forward
    puts "Поезд #{train.number} отправился со станции #{train.current_station.name} на станцию #{train.prev_station.name}"
  end

  def find_train(title)
    @trains.find { |el| el.number == title }
  end

  def trains_list
    print 'Список поездов: '
    @trains.each { |el| puts el.number }
  end

  def routes_list
    @routes.each { |el| puts el }
  end

  def select_stations(name)
    @stations.find { |el| el.name == name }
  end

  def select_route(idx)
    @routes[idx]
  end

  def routes_menu
    loop do
      puts "
      --- Меню маршрутов --- 
      Введите номер:
      1. Создать маршрут
      2. Добавить станцию к маршруту
      3. Удалить станцию из маршрута
      4. Вернуться в главное меню
      5. Выйти из программы
      "

      choice = gets.chomp.to_i
      case choice
      when 1
        create_route
      when 2
        add_station_to_route
      when 3
        remove_station_from_route
      when 4
        break
      when 5
        exit
      else
        puts "Неправильно набран номер. Попробуйте еще раз."
      end
    end
  end

  def create_route
    if @stations.length < 2
      puts "Нужно не меньше двух станций для создания маршрута."
    end

    puts 'Введите первую станцию'
    name1 = gets.chomp
    first_station = select_stations(name1)
    puts 'Введите конечную станцию'
    name2 = gets.chomp
    last_station = select_stations(name2)
    
    @routes << Route.new(first_station, last_station)
    puts "Маршрут от станции '#{first_station.name}' до станции '#{last_station.name}' создан."
    puts "#{stations_list}"
    puts
    puts "#{routes_list}"
  end

  def add_station_to_route
    routes_list
    puts "Назовите маршрут(индекс)."
    idx = gets.chomp.to_i
    route = select_route(idx)
    puts "Маршрут #{route}: номер #{idx}."

    puts "Назовите станцию, которую нужно добавить: "
    name = gets.chomp
    station = select_stations(name)
    route.add_station(station)
    
    puts "#{route}"
    puts
    puts "Станция #{station.name} добавлена."
    puts
    puts "#{@routes}"
  end

  def remove_station_from_route
    puts "Назовите маршрут(индекс)."
    idx = gets.chomp.to_i
    route = select_route(idx)
    puts "#{route}"

    puts "Назовите станцию, которую нужно удалить: "
    name = gets.chomp
    station = select_stations(name)
    route.remove_station(station)
    
    puts "#{@routes}"
    puts "Станция #{station.name} удалена."
  end
end

Interface.new.main_menu


