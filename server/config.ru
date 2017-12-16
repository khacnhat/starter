require 'rack'
require_relative 'src/cacher'
require_relative 'src/rack_dispatcher'

cacher = Cacher.new
cacher.write_display_names_cache('languages')
cacher.write_display_names_cache('custom')
cacher.write_exercises_cache

run RackDispatcher.new
