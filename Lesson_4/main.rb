require_relative "station"
require_relative "route"
require_relative "train"
require_relative "cargo_train"
require_relative "passenger_train"
require_relative "wagons"
require_relative "passenger_wagons"
require_relative "cargo_wagons"


# - Создавать станции
#      - Создавать поезда
#      - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
#      - Назначать маршрут поезду
#      - Добавлять вагоны к поезду
#      - Отцеплять вагоны от поезда
#      - Перемещать поезд по маршруту вперед и назад
#      - Просматривать список станций и список поездов на станции
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

  def stations_menu
    loop do
      puts '
      --- Меню станций ---
      Введите номер:
      1. Создать станцию
      2. Просмотреть список всех станций
      3. Вернуться в главное меню
      4. Выйти из прграммы
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
        go_to_previous_station
      when 7
        break
      when 8
        exit
      else
        puts "Неправильно набран номер. Попробуйте еще раз."
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
    puts 'Введите число, что бы выбрать маршрут.'
    choice = gets.chomp.to_i
    @routes.each { |route| puts "Ваш маршрут: #{route.all_stations[0]} - #{route.all_stations[-1]} под номером #{choice} создан." }
  end

  # def add_wagon
  
  #   puts 'Это грузовой вагон или пассажирский? 1-(грузовой), 2-(пассажирский). Введите число: '
  #   choice = gets.chomp.to_i

  #   case choice
  #   when 1
  #     train = CargoTrain.new
  #     train.add_wagon(PassengerWagons.new)
  #     puts 'Вагон добавлен к грузовому поезду.'
  #   when 2
  #     PassengerTrain.new(number).add_wagon(PassengerWagons.new)
  #     puts 'Вагон добавлен к пассажирскому поезду.'
  #   else
  #     puts puts 'Что-то пошло не так.'

  #     loop do
  #       puts 'Придется повторить. Введите число: '
  #       choice = gets.chomp.to_i

  #       case choice
  #       when 1 then add_wagon
  #       when 2 then break
  #       else puts 'Повторите ввод.'
  #       end
  #     end
  #   end
  # end

  def create_wagon(type)
    if type == :cargo
      CargoWagons.new
    elsif type == :passenger
      PassengerWagons.new
    end
  end



  # def add_wagon
  #   trains_list
  #   puts 'Выберите поезд:'
  #   choice = gets.chomp.to_i
  #   train = @trains[choice]
  #   puts "Какой тип вагона добавить?"
  #   wagon = CargoWagons.new if train.type == :cargo
  #   wagon = PassengerWagons.new if train.type == :passenger
  #   train.add_wagon(wagon)
  #   puts 'Вагон добавлен к поезду.'
  # end

  def add_wagon
    trains_list
    puts 'Выберите поезд:'
    title = gets.chomp
    pp train = find_train(title)
    
    puts "Какой тип вагона добавить?"
    type = gets.chomp.to_sym
    wagon = create_wagon(type)
    train.add_wagon(wagon) #if train.train_speed
    puts 'Вагон добавлен к поезду.'

    # puts "Какой тип вагона добавить?"
    # type = gets.chomp.to_sym
    # if train.type == :cargo
    #   wagon = CargoWagons.new
    #   train.add_wagon(wagon)
    #   puts 'Вагон добавлен к поезду.'
    # else
    #   wagon = PassengersWagons.new
    #   train.add_wagon(wagon)
    #   puts 'Вагон добавлен к поезду.'
    # end
  end

  # def train_speed
  #   @trains.each { |el| el.speed == 0 }
  # end

  def find_train(title)
    @trains.find { |el| el.number == title }
  end

  def trains_list
    print 'Список поездов: '
    @trains.each { |el| puts el.number }
  end

  # def remove_wagon
  #   trains_list
  #   puts 'Выберите поезд.'
  #   choice = gets.chomp
  #   train = find_train(choice)

  #   puts "Какой тип вагона удалить?"
  #   type = gets.chomp.to_sym
  #   wagon = create_wagon(type)
  #   train.remove_wagons(wagon)
  #   puts 'Вагон добавлен к поезду.'
  # end

  def current_station
    trains_list
    puts 'Какой поезд сейчас стоит на станции?'
    title = gets.chomp
    train = find_train(title)
    train_station = train.current_station
    puts "Поезд сейчас стоит на станции #{train_station}"
  end

  def go_to_next_station
    trains_list
    puts 'Какой поезд сейчас стоит на станции?'
    title = gets.chomp
    train = find_train(title)
    train_station = train.move_forward
    puts "Поезд сейчас идет до станции #{train_station}"
  end

  def go_to_previuos_station
    trains_list
    puts 'Какой поезд сейчас стоит на станции?'
    title = gets.chomp
    train = find_train(title)
    train_station = train.move_back
    puts "Поезд сейчас идет до станции #{train_station}"
  end


  def select_stations(name)
    @stations.select { |el| el.name == name }
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
    @first_station = gets.chomp.to_s
    @stations << Station.new(@first_station)
    puts 'Введите конечную станцию'
    @last_station = gets.chomp.to_s
    @stations << Station.new(@last_station)
    @routes << Route.new(@first_station, @last_station)
    puts "Маршрут от станции '#{@first_station}' до станции '#{@last_station}' создан."
  end

  def add_station_to_route
    puts "Назовите станцию, которую нужно добавить: "
    station = gets.chomp.to_s
    @routes.each { |el| el.inters << station }
    all = @routes.each { |el| el.all_stations } 
    puts "#{all.each { |el| el }}"
    puts "Станция #{station} добавлена."
  end

  def remove_station_from_route
    puts "Назовите станцию, которую нужно удалить: "
    station = gets.chomp.to_s
    @routes.each { |el| el.inters.delete(station) if el.inters.include?(station) }
    puts "Станция #{station} удалена."
  end
end

Interface.new.main_menu