RailsMiddlewareDelegator
========================

When using Rails middleware, a common problem is that middleware loaded from `lib`
does not reload between requests. In order for changes to these middleware classes
to be reflected in a running server, the development server process must be
killed and restarted.

If one were to drop a middleware class into a subdirectory of `app` and rely on
autoloading, however, changing any other autoloaded file and making a new
server request results in an error, `A copy of X has been removed from the module
tree bus is still active`. Upon starting the server, an instance of the class was
loaded into memory. At the end of the request, the class was unloaded. On the
second request upon running through the middleware stack, Rails detected that it
was executing through an instance of an unloaded class. Boom!

This gem provides a delegator class that can wrap the unloadable middleware. Instead
of registering the middleware itself, you can use an instance of the delegator,
which being a gem managed by bundler will not be unloaded between requests.

In environments where `cache_classes` is `true`, the delegator steps out of the way
and adds the delegated middleware directly onto the stack. When `false`, it holds
onto any passed configuration and instantiates a new middleware instance for each
request.


## Usage

```
Rails.application.config.middleware.use RailsMiddlewareDelegator.new('MyMiddleware')
```


## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/[USERNAME]/rails_middleware_delegator. This project is intended
to be a safe, welcoming space for collaboration, and contributors are expected to
adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

