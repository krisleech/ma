require 'wisper_next'

module Ma
  module Subscriber
    def self.included(base)
      base.extend(ClassMethods)
      base.include(WisperNext.subscriber)
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
