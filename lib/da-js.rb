require "da-js/version"

module Da
  module Js
    # We need to subclass Rails::Engine, so that Rails adds our assets directory to its assets search path.
    class Engine < ::Rails::Engine
    end
  end
end
