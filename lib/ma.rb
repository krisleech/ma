require "ma/version"
require "ma/publisher"
require "ma/subscriber"
require "ma/event"

module Ma
  class Error < StandardError; end

  def self.subscriber(*args)
    Subscriber.new(*args)
  end
end
