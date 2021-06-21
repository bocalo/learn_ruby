require_relative 'validation.rb'

module Accessors
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def attr_accessors_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        var_name_history = "@#{name}_history".to_sym
        define_method(name) { instance_variable_get(var_name) }

        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value) 
          @history ||= {}
          @history[name] ||= []
          @history[name] << value
        end

        define_method("#{name}_history") { @history[name] }
      end
    end

    def strong_attr_accessor(name, klass)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do |value|
        raise(StandartError, 'Incorrect class') unless value.class == klass
        instance_variable_set(var_name, value)
      end
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.send :attr_accessors_with_history, :strong_attr_accessor
    end
  end
end



