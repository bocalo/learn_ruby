module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :count
    
    def count_instances
      self.count ||= 0
      self.count += 1
    end
  end

  module InstanceMethods

    protected
    
    def register_instance
      self.class.count_instances 
    end
  end
end