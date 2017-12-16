require 'json'
require_relative 'cacher'
require_relative 'indexer'

class Starter

  def unknown(method_name)
    raise RuntimeError.new("#{method_name}:unknown_method")
  end

  def languages_choices(recent_display_name)
    cache = Cacher.new.read_display_names_cache('languages')
    Indexer.new(cache).align(recent_display_name)
    cache
  end

  # - - - - - - - - - - - - - - - - -

  def exercises_choices(exercise_name)
    cache = Cacher.new.read_exercises_cache
    #kata_id promotes repetition
    #returns a list of exercises
    #and an initial index
  end

  # - - - - - - - - - - - - - - - - -

  def custom_choices(display_name)
    #kata_id promotes repetition
    #returns a major-list and a minor-list
    #and initial indexes for both lists
  end

  # - - - - - - - - - - - - - - - - -

  def languages_manifest(display_name, exercise_name)
    #returns the manifest for the web to pass to storer
  end

  def custom_manifest(display_name)
    #returns the manifest for the web to pass to storer
  end

end

