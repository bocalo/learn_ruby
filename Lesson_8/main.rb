# frozen_string_literal: true

require 'byebug'
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'wagons'
require_relative 'passenger_wagons'
require_relative 'cargo_wagons'

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
      when 1 then stations_menu
      when 2 then trains_menu
      when 3 then routes_menu
      when 4 then exit
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
      when 1 then create_station
      when 2 then stations_list
      when 3 then break
      when 4 then exit
      else
        puts 'Неправильно набран номер. Попробуйте еще раз.'
      end
    end
  end

  def create_station
    print 'Введите название станции: '
    name = gets.chomp.to_s
    @stations << Station.new(name)
    puts "Станция '#{name}' создана."
  rescue ArgumentError => e
    puts e.message
    retry
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
      7. Информация о вагоне
      8. Занять место или объем
      9. Вернуться в главное меню
      0. Выйти из программы
      "
      choice = gets.chomp.to_i

      case choice
      when 1 then create_train
      when 2 then set_route_to_train
      when 3 then add_wagon
      when 4 then remove_wagon
      when 5 then go_to_next_station
      when 6 then go_to_back_station
      when 7 then info_wagon
      when 8 then take_seat_or_volume
      when 9 then break
      when 0 then exit
      else
        puts 'Неправильно набран номер. Попробуйте еще раз.'
      end
    end
  end

  def create_train
    print 'Введите номер поезда: '
    number = gets.chomp
    print 'Выберите тип поезда. 1-(грузовой), 2-(пассажирский). Введите число: '
    train_type = gets.chomp.to_i

    if train_type == 1
      @trains << CargoTrain.new(number)
      puts "Создан грузовой поезд номер #{number}."
    elsif train_type == 2
      @trains << PassengerTrain.new(number)
      puts "Создан пассажирский поезд номер #{number}."
    elsif train_type != 1 || train_type != 2
      puts 'Неправильный тип поезда. Нужно 1 или 2.'
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def set_route_to_train
    routes_list
    puts 'Выберите маршрут(индекс).'
    idx = gets.chomp.to_i
    route = select_route(idx)
    puts "Маршрут с индексом #{idx} назначен: #{route}"

    trains_list
    puts 'Выберите поезд.(номер поезда)'
    title = gets.chomp

    train = find_train(title)
    puts train.to_s

    train.define_route(route)
    puts 'Ваш маршрут создан.'
    print 'Этот маршрут проходит через станции: '
    route.all_stations.each { |el| puts el.name }
  end

  def add_wagon
    trains_list
    puts 'Выберите поезд:'
    title = gets.chomp
    # puts 'Не тот номер' if title != NUMBER_FORMAT
    train = find_train(title)

    if train.type == :cargo
      train.add_wagon(CargoWagons.new)
      puts "Грузовой вагон вместимостью #{CargoWagons.new.space} кубов добавлен к поезду #{train.number}. У этого поезда количество вагонов: #{train.wagons.size}."

    elsif train.type == :passenger
      train.add_wagon(PassengerWagons.new)
      puts " Пассажирский вагон вместимостью #{PassengerWagons.new.space} мест добавлен к поезду #{train.number}. У этого поезда количество вагонов: #{train.wagons.size}."
    else
      puts 'Некуда прицеплять.'
    end
  rescue NoMethodError => e
    puts e.message
    retry
  end

  # def input_info
  #   trains_list
  #   puts 'Выберите поезд.'
  #   title = gets.chomp
  #   train = find_train(title)
  # end

  def remove_wagon
    trains_list
    puts 'Выберите поезд.'
    title = gets.chomp
    train = find_train(title)
    if train.type == :cargo && !train.wagons.empty?
      train.remove_wagons(CargoWagons.new)
      puts "Отцепляем грузовой вагон вместимостью #{CargoWagons.new.space} кубов. Вагон отцеплен от поезда #{train.number}"
    elsif train.type == :passenger && !train.wagons.empty?
      train.remove_wagons(PassengerWagons.new)
      puts "Отцепляем пассажирский вагон вместимостью #{PassengerWagons.new.space} мест. Вагон отцеплен от поезда #{train.number}"
    else
      puts 'Нечего отцеплять.'
    end
  rescue ArgumentError => e
    puts e.message
    retry
  end

  def info_wagon
    trains_list
    puts 'Выберите поезд'
    title = gets.chomp
    train = find_train(title)
    raise ArgumentError, 'Не то название' if train.nil?

    if train.type == :cargo
      train.each_wagon { |wagon, index| puts "Вагон номер: #{index + 1} - #{wagon} - объем: #{wagon.space}" }
    elsif train.type == :passenger
      train.each_wagon { |wagon, index| puts "Вагон номер:#{index + 1} - #{wagon} - Вместимость(мест): #{wagon.space} " }
    else
      puts 'Никаких вагонов.'
    end
  rescue ArgumentError => e
    puts e.message
    retry
  end

  def take_seat_or_volume
    trains_list
    puts 'Выберите поезд'
    title = gets.chomp
    train = find_train(title)
    puts 'У этого поезда нет вагонов.' if train.wagons.empty?
    wagons_list(train)
    puts 'Выберите вагон(индекс).'
    wagon = train.wagons[gets.to_i]
    raise StandardError, 'Не то название вагона' if wagon.nil?

    puts wagon.to_s
    if wagon.type == :cargo
      cargo_w(wagon)
    elsif wagon.type == :passenger
      passenger_w(wagon)
    else
      puts 'Нет вагонов.'
    end
  rescue StandardError => e
    puts e.message
    retry
  end

  def cargo_w(wagon)
    puts 'Сколько надо загрузить?'
    place = gets.to_i
    if (wagon.free_space - place).positive?
      puts "В вагоне останетсяся объем - #{wagon.free_space - place} кубов."
      puts 'Загружайте'
    else
      puts "В вагоне останетсяся объем - #{wagon.free_space - place} кубов."
    end
  end

  def passenger_w(wagon)
    puts 'Сколько мест вам нужно?'
    place = gets.to_i
    if (wagon.free_space - place).positive?
      puts 'Занимайте места.'
    else
      puts 'Свободных мест нет.'
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

  def wagons_list(train)
    train.each_wagon { |wagon, index| puts "#{index + 1} - #{wagon.type} - #{wagon.space}" }
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
      when 1 then create_route
      when 2 then add_station_to_route
      when 3 then remove_station_from_route
      when 4 then break
      when 5 then exit
      else
        puts 'Неправильно набран номер. Попробуйте еще раз.'
      end
    end
  end

  def create_route
    if @stations.length < 2
      puts 'Нужно не меньше двух станций для создания маршрута.'
    else
      puts 'Все нормально.'
    end
    begin
      puts 'Введите первую станцию'
      name1 = gets.chomp
      first_station = select_stations(name1)
      puts 'Введите конечную станцию'
      name2 = gets.chomp
      last_station = select_stations(name2)

      @routes << Route.new(first_station, last_station)
      puts "Маршрут от станции '#{first_station.name}' до станции '#{last_station.name}' создан."
    rescue ArgumentError => e
      puts e.message
      retry
    end
  end

  def add_station_to_route
    routes_list
    puts 'Назовите маршрут(индекс).'
    idx = gets.chomp.to_i
    route = select_route(idx)
    puts "Маршрут #{route}: номер #{idx}."

    puts 'Назовите станцию, которую нужно добавить: '
    name = gets.chomp
    station = select_stations(name)
    route.add_station(station)
    puts route.to_s
    puts "Станция #{station.name} добавлена."
    @routes
  end

  def remove_station_from_route
    puts 'Назовите маршрут(индекс).'
    idx = gets.chomp.to_i
    route = select_route(idx)

    puts 'Назовите станцию, которую нужно удалить: '
    name = gets.chomp
    station = select_stations(name)
    route.remove_station(station)

    puts "Станция #{station.name} удалена."
  end
end

Interface.new.main_menu
