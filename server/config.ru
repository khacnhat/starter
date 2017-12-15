require 'rack'
require_relative './src/rack_dispatcher'

#TODO: build /tmp/starter/languages_cache.json
#TODO: ENV['CYBER_DOJO_START_POINTS_ROOT'] is where to read from
#TODO: make it a cache of the 4 pieces of data
#      major_names,minor_names,minor_indexes,initial_index
#      so only the recent_display_name index-0 alteration is needed.

run RackDispatcher.new
