require 'json'
require_relative 'cacher'
require_relative 'cache_index_matcher'

class Starter

  def languages_choices(current_display_name)
    cacher = Cacher.new
    cache = cacher.read_display_names_cache('languages')
    matcher = CacheIndexMatcher.new(cache)
    matcher.match_display_name(current_display_name)
    cache
  end

  # - - - - - - - - - - - - - - - - -

  def exercises_choices(current_exercise_name)
    cacher = Cacher.new
    cache = cacher.read_exercises_cache
    matcher = CacheIndexMatcher.new(cache)
    matcher.match_exercise_name(current_exercise_name)
    cache
  end

  # - - - - - - - - - - - - - - - - -

  def custom_choices(current_display_name)
    cacher = Cacher.new
    cache = cacher.read_display_names_cache('custom')
    matcher = CacheIndexMatcher.new(cache)
    matcher.match_display_name(current_display_name)
    cache
  end

  # - - - - - - - - - - - - - - - - -

  def languages_manifest(display_name, exercise_name)
    #returns the manifest for the web to pass to storer
  end

  def custom_manifest(display_name)
    #returns the manifest for the web to pass to storer
  end

  # - - - - - - - - - - - - - - - - -

  def unknown(method_name)
    raise RuntimeError.new("#{method_name}:unknown_method")
  end

end

