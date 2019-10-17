RSpec.describe Ma::Publisher do
  describe '#broadcast' do
    it 'broadcasts an event' do
      publisher = Class.new do
        include Ma::Publisher
        public :broadcast
      end.new

      event_class = double(name: 'MyEvent')
      event = double(to_h: { a: :b }, class: event_class)

      listener = double

      expect(listener).to receive(:on_event).with(event_class.name, event.to_h)

      publisher.subscribe(listener)

      publisher.broadcast(event)
    end
  end
end
