# Ma 間

**Events as first class citizens**

> Ma (間) is a Japanese word, it is between spoken words and musical notes.
> The essence of minimalism, a gap, pause or space.

* An alternative to callbacks and observers
* Connect objects based on context without permanence
* Handle events synchronously or asynchronously
* Loosely couple objects with events
* A micro library, can be grokked in a day

## Usage

```ruby
class MyEvent < Ma::Event
end

class MyPublisher
  include Ma.publisher

  def call
    # ...
    broadcast(MyEvent.new(user: user))
  end
end

class MyListener
  include Ma.subscriber

  on(MyEvent) do |event|
    # ...
  end
end

publisher = MyPublisher.new
publisher.subscribe(MyListener.new)
publisher.call
```

#### Handling Events Asynchronously

Ma is build on top of [WisperNext](https://gitlab.com/kris.leech/wisper_next)
and so takes advantage it's asynchronous adapters.

[Configure an adapter](https://gitlab.com/kris.leech/wisper_next#handling-events-asynchronously) and then pass `:async` as such:

```ruby
class MyListener
  include Ma.subscriber(:async)
end
```

### Events

An event can be any object which must:

* be initialized with a `Hash` of attributes
* responds to `#to_h` returning a `Hash` of attributes

We provide a simple event object, `Ma::Event`, but would recommend using
something like [dry-struct](https://dry-rb.org/gems/dry-struct/1.0/) to define an
event explicitly.

A useful constraint, when using dry-struct, if you are using asynchronous listeners, is that
it only supports primative types like `String`, `Integer`, `Hash` and
`Array`, which are easily serialized for transport over the wire to a background
worker.

#### Enhancing Events

You can add additional information to the payload by overriding the
`#initialize` method:

```ruby
class MyEvent < Ma::Event
  def initialize(attrs)
    super({ timestamp: Time.now.to_i }.merge(attrs))
  end
end
```

## Installation

```ruby
gem 'ma'
```

## Security

* gem releases are [signed](https://gitlab.com/kris.leech/ma/blob/master/keys/gem-public_cert.pem)
* commits are GPG [signed](https://gitlab.com/kris.leech/ma/blob/master/keys/kris.leech.gpg.public)

## Development

### Specs

Run the specs:

```
rspec
```

Runs the specs on file change:

```
ls ./**/*.rb | entr -c rspec
```

## Contributing

Bug reports are welcome on Gitlab at https://gitlab.com/kris.leech/ma.

We are unlikely to accept new feature requests, but please open an issue if you
feel you have something completing and would be prepared to provide a pull
request.

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ma project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://gitlab.com/kris.leech/ma/CODE_OF_CONDUCT.md).
