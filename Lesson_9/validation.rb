#frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, type, options={})
      @validations ||= []
      @validations << ["@#{name}".to_sym, type, options]
    end
  end

  module InstanceMethods
    
    def validate!
      self.class.validations.each do |value|
        name, type, options = value
        send(type, name, options)
      end
    end

    def valid?
      validate!
    rescue StandardError
      false
    end

    private
  
    def presence(name, _params)
      var = instance_variable_get(name)
      raise 'Ошибка: Значение не может быть пустым!' if var.empty?
    end

    def format(name, format)
      var = instance_variable_get(name)
      raise 'Ошибка: Не верный формат вводимых значений!' if var !~ format
    end

    def type(name, type)
      var = instance_variable_get(name)
      raise 'Ошибка: Не верный тип данных!' unless var.class == type
    end
  end
end


