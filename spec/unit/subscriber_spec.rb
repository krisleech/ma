RSpec.describe Ma::Subscriber do
  describe '#on' do
    it 'creates a event method named after Event class' do
      stub_const('UserPromotedEvent', double(name: 'UserPromotedEvent'))

      subscriber = Class.new do
        include Ma::Subscriber.new

        on(UserPromotedEvent) {}
      end.new

      expect(subscriber).to respond_to(:UserPromotedEvent)
    end

    it 'creates a event method named after Event class with artiy of 1' do
      class UserPromotedEvent
      end

      subscriber = Class.new do
        include Ma::Subscriber.new

        on(UserPromotedEvent) {}
      end.new

      expect(subscriber.method(:UserPromotedEvent).arity).to eq(1)
    end

    describe 'when :async option passed' do
      describe 'and async broadcaster is defined' do
        it 'uses async broadcaster' do
          async_broadcaster = double
          async_broadcaster_class = double(new: async_broadcaster)

          stub_const('UserPromotedEvent', double('UserPromotedEvent', new: double('user_promoted_event'), name: 'UserPromotedEvent'))
          stub_const('WisperNext::Subscriber::AsyncBroadcaster', async_broadcaster)

          expect(async_broadcaster).to receive(:new)

          subscriber = Class.new do
            include Ma::Subscriber.new(:async)

            on(UserPromotedEvent) {}
          end.new

          subscriber.send(:UserPromotedEvent, UserPromotedEvent.new)
        end
      end
    end
  end
end
