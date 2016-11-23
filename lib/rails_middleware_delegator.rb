require 'rails_middleware_delegator/version'
require 'active_support/inflector'
require 'active_support/string_inquirer'

# RailsMiddlewareDelegator
#
# Used to wrap a reloadable class used as Rails middleware. In development mode
# with `cache_classes=false`, after each request all autoloaded modules and
# classes are unloaded. If one of these classes is used as Rails middleware,
# then it can cause the following error:
#
#   A copy of ZZZ has been removed from the module tree but is still active
#
# This is because Rails will hold onto an instance of the class.
#
# Instead of using the middleware class itself, use an instance of the
# delegator:
#
#   Rails.application.config.
#     middleware.use RailsMiddlewareDelegator.new('MyMiddlware')
#
class RailsMiddlewareDelegator
  attr_reader :klass, :initialization_args

  def initialize(klass)
    @klass = klass
  end

  def class
    klass
  end

  def new(*args)
    @initialization_args = args
    Rails.env.development? ? self : klass.constantize.new(*args)
  end

  def call(*args)
    klass.constantize.new(*initialization_args).call(*args)
  end
end
