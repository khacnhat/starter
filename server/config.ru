require 'rack'
require_relative 'src/cacher'
require_relative 'src/rack_dispatcher'

cacher = Cacher.new
cacher.write_display_names_caches('languages')
cacher.write_display_names_caches('custom')
cacher.write_exercises_cache

run RackDispatcher.new
