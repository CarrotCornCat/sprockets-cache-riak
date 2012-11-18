require "digest/md5"

module Sprockets
  module Cache
    # A simple Riak cache store.
    #
    #     environment.cache = Sprockets::Cache::RiakStore.new($riak)
    #
    class RiakStore

      def initialize(riak_client, bucket = "sprockets")
        @riak   = riak_client
        @bucket = @riak.bucket(bucket)
      end

      # Lookup value in cache
      def [](key)
        object = @bucket.get_or_new sanitize_key(key)
        object.data if object.data
      end

      # Save value to cache
      def []=(key, value)
        object              = @bucket.get_or_new sanitize_key(key)
        object.raw_data     = Marshal.dump(value)
        object.content_type = "application/x-ruby-marshal"
        object.store
        value
      end

      private

      def sanitize_key(key)
        ::Digest::SHA1.hexdigest key
      end

    end
  end
end
