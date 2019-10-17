require 'ostruct'

module Ma
  class Event < OpenStruct
    def initialize(*args)
      super
      freeze
    end
  end
end
