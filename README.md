# Ma 間

*A micro library providing Ruby objects with the ability to Publish Events and Subscribe to Events*

> Ma (間) is a Japanese word which can be roughly translated as "gap", "space", "pause" or "the space between two structural parts."

* Use as an alternative to callbacks and observers
* Connect objects based on context without permanence
* Publish events synchronously or asynchronously

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
and as such can take advantage of the [async adapters](https://gitlab.com/kris.leech/wisper_next#handling-events-asynchronously).

Configure an adapter and then pass `:async` as such:

```ruby
class MyListener
  include Ma.subscriber(:async)
end
```

### Events

The event can be any object which is:

* initialized with a `Hash` of attributes
* responds to `#to_h` returning a `Hash` of attributes

We provide a simple Struct-like event object, `Ma::Event`, but would recommend using some
thing like [dry-struct](https://dry-rb.org/gems/dry-struct/1.0/) to define an
event schema.

A useful constraint, if you are using asynchronous listeners, is that
dry-struct only supports primative types like `String`, `Integer`, `Hash` and
`Array, which are easily serialized for transport over the wire to a background
worker.

#### Enhancing Events

You can add additional information to the payload by either overriding the
`#initialize` method:

```ruby
class MyEvent < Ma::Event
  def initialize(attrs)
    super({ timestamp: Time.now.to_i }.merge(atrs))
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

Bug reports and pull requests are welcome on Gitlab at https://gitlab.com/kris.leech/ma.

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ma project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://gitlab.com/kris.leech/ma/CODE_OF_CONDUCT.md).
