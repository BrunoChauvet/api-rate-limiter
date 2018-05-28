module Rack
  class RateLimiter
    attr_reader :app

    def initialize(app)
      @app = app
      @limit_calls = Settings.rate_limiter.calls
      @limit_period = Settings.rate_limiter.period
    end

    def call(env)
      request = Rack::Request.new(env)
      throttle?(request) ? throttle(request) : app.call(env)
    end

    private

    def throttle?(request)
      key = cache_key(request)

      # Increment the request counter for this client
      counter = $redis.incr(key)

      # Set expiration time
      $redis.expire(key, @limit_period) if counter == 1

      counter > @limit_calls
    end

    # Throttle the request returning a 429 error
    def throttle(request)
      time_left = $redis.ttl(cache_key(request))
      [429, {}, ["Rate limit exceeded. Try again in #{time_left} seconds."]]
    end

    # Generate a cache key based on client IP and current rate limit period
    def cache_key(request)
      period_hash = Time.now.to_i / @limit_period
      "#{request.ip}/#{period_hash}"
    end
  end
end
