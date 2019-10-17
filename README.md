# Ma 間

> Ma (間) is a Japanese word which can be roughly translated as "gap", "space", "pause" or "the space between two structural parts."

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

### Event class

The event can be any object which is:

* initialized with a `Hash` of attributes
* responds to `#to_h` returning a `Hash`

We provide a simple Struct-like event object, `Ma::Event`, but would recommend using some
thing like [dry-struct](https://dry-rb.org/gems/dry-struct/1.0/) to define an
event schema.

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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ma. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ma project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ma/blob/master/CODE_OF_CONDUCT.md).
