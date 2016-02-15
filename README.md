# RejectDeeplyNested

[![Gem Version](https://badge.fury.io/rb/reject_deeply_nested.svg)](https://badge.fury.io/rb/reject_deeply_nested) [![Build Status](https://travis-ci.org/ignat-zakrevsky/reject_deeply_nested.svg?branch=master)](https://travis-ci.org/ignat-zakrevsky/reject_deeply_nested)

Gem for rejecting deeply nested structures when you are using `accept_nested_attributes_for`. Using recursive traverse instead of stack because of [this](<https://gist.github.com/ignat-zakrevsky/6779db323c64faf4ed89>).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'reject_deeply_nested'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install reject_deeply_nested

## Usage

There are two cases of using `reject_deeply_nested`

When you simply want to reject nested blank values:

```ruby
accepts_nested_attributes_for :dependents,
  reject_if: RejectDeeplyNested.blank?
```

Other case, when you want to ignore some additional fields, for example id's keys

```ruby
accepts_nested_attributes_for :dependents,
  reject_if: RejectDeeplyNested.blank?(ignore_values: [/_id$/])
```

Additionaly, if you want to reject not complete filled attributes you can use
```ruby
accepts_nested_attributes_for :dependents,
  reject_if: RejectDeeplyNested.has_missed_fields?(['name', 'age'])
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ignat-zakrevsky/reject_deeply_nested.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

