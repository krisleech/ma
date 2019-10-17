RSpec.describe Ma::Subscriber do
  describe '#on' do
    it 'creates a event method named after Event class' do
      stub_const('UserPromotedEvent', double(name: 'UserPromotedEvent'))

      subscriber = Class.new do
        include Ma::Subscriber

        on(UserPromotedEvent) {}
      end.new

      expect(subscriber).to respond_to(:UserPromotedEvent)
    end

    it 'creates a event method named after Event class with artiy of 1' do
      class UserPromotedEvent
      end

      subscriber = Class.new do
        include Ma::Subscriber

        on(UserPromotedEvent) {}
      end.new

      expect(subscriber.method(:UserPromotedEvent).arity).to eq(1)
    end
  end
end
