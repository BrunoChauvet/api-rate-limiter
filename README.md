# API Rate Limiter

## Description
For this challenge, you'll start off by creating a new rails application. You can include any gems or other libraries you consider will be helpful but don’t use a gem for the rate limiting.

Create a new controller, perhaps called "home", with an index method. This should return only the text string "ok".

The challenge is to implement rate limiting on this route. Limit it such that a requester can only make 100 requests per hour. After the limit has been reached, return a 429 with the text "Rate limit exceeded. Try again in #{n} seconds".

## Implementation details
The Rack Middleware `Rack::RateLimiter` maintains a counter of requests sent by the application clients over each 1 hour time period.
Redis is used to persist the counter so the solution can scale horizontaly.

## Test suite
![build](https://travis-ci.org/BrunoChauvet/api-rate-limiter.svg?branch=master "TravisCI Build")
Rspec tests have been implemented to cover different scenarios when reaching the rate limit threshold or entering a new rate limit time window.
The test suite can be run with the command `rake` and also include static code analysis and code coverage.
