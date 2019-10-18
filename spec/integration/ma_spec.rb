RSpec.describe 'Ma' do
  class MyEvent < Ma::Event
  end

  class Publisher
    include Ma::Publisher

    def call(name)
      broadcast(MyEvent.new(name: name))
    end
  end

  class Subscriber
    include Ma.subscriber

    attr_accessor :actual_event

    on(MyEvent) do |event|
      self.actual_event = event
    end
  end

  it 'allows publishing and subscribing using event objects' do
    name = 'Kris'
    publisher = Publisher.new
    subscriber = Subscriber.new
    publisher.subscribe(subscriber)
    publisher.call(name)
    expect(subscriber.actual_event).to be_an_instance_of(MyEvent)
  end
end
