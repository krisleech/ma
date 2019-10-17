require 'wisper_next'

module Ma
  module Publisher
    module Overrides
      def broadcast(event)
        name = event.class.name
        super(name, event.to_h)
      end
    end

    def self.included(base)
      base.include(WisperNext.publisher)
      base.include(Overrides)
    end
  end
end
