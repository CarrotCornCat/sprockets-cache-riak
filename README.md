# Sprockets Riak Cache

A cache store for Sprockets which utilities Riak.


## Usage

Gemfile:

```ruby
gem "sprockets"
gem "sprockets-cache-riak"
# ...
```

config.ru:

```ruby
require "sprockets-cache-riak"
env = Sprockets::Environment.new
env.cache = Sprockets::Cache::RiakStore.new(riak, "sprockets")
# ...
```

Where the first argument is a Riak::Client connection (riak-ruby-client by Basho), and the other (which is optional) is a bucket name.
