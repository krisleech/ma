require 'wisper_next'

module Ma
  class Subscriber < Module

    def initialize(*args)
      @options = WisperNext::CastToOptions.(args)
    end

    def included(base)
      base.extend(ClassMethods)
      base.include(WisperNext.subscriber(@options.slice(:async)))
      super
    end

    module ClassMethods
      def on(event_class, &block)
        define_method event_class.name do |payload|
          instance_exec(event_class.new(payload), &block)
        end
      end
    end
  end
end
