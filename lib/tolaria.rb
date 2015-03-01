require "securerandom"

require "clearance"
require "sass"

require "tolaria/version"
require "tolaria/engine"
require "tolaria/config"
require "tolaria/default_config"

require "tolaria/admin"
require "tolaria/reload"
require "tolaria/manage"
require "tolaria/routes"

module Tolaria
  # We have to autoload these classes because they inherit
  # from a Rails class (Rails must boot first)
  autoload :TolariaController, "tolaria/controllers/tolaria_controller"
  autoload :AuthenticationController, "tolaria/controllers/authentication_controller"
  autoload :ResourceController, "tolaria/controllers/resource_controller"
  autoload :ManagedClass, "tolaria/managed_class"
end
