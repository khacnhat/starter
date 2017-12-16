require 'json'
require_relative 'cacher'
require_relative 'cache_index_matcher'
require_relative 'time_now'
require_relative 'unique_id'

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

  def language_manifest(display_name, exercise_name)
    # [1] Issue: [] is not a valid progress_regex. It needs two regexs.
    # This affects zipper.zip_tag()

    cacher = Cacher.new
    dir_cache = cacher.read_dir_cache('languages')
    dir = dir_cache[display_name]
    manifest = JSON.parse(IO.read("#{dir}/manifest.json"))
    manifest['id'] = unique_id
    manifest['created'] = time_now
    manifest['filename_extension'] ||= ''
    manifest['highlight_filenames'] ||= []
    manifest['progress_regexs'] ||= []       # [1]
    manifest['highlight_filenames'] ||= []
    # TODO: 'lowlight_filenames'
    # TODO: 'language'
    manifest['max_seconds'] ||= 10
    manifest['tab_size'] ||= 4
    visible_filenames = manifest['visible_filenames']
    manifest.delete('visible_filenames')
    manifest['visible_files'] =
      Hash[visible_filenames.collect { |filename|
        [filename, IO.read("#{dir}/#{filename}")]
      }]
    manifest['visible_files']['output'] = ''

    manifest['exercise'] = exercise_name
    content = cacher.read_exercises_cache['contents']
    manifest['visible_files']['instructions'] = content[exercise_name]
    manifest
  end

  # - - - - - - - - - - - - - - - - -

  def custom_manifest(display_name)
    #TODO: returns the manifest for the web to pass to storer
  end

  # - - - - - - - - - - - - - - - - -

  def method_missing(name, *_args, &_block)
    raise RuntimeError.new("#{name}:unknown_method")
  end

  private

  include TimeNow
  include UniqueId

end
