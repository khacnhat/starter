require 'json'
require_relative 'major_name'
require_relative 'minor_name'
require_relative 'splitter'

class Cache

  def initialize
    @cache = {}
    cache_display_names('languages')
    cache_display_names('custom')
    cache_exercises
  end

  # - - - - - - - - - - - - - - - - - - - -
  # Used to offer choices

  def of_display_names(name)
    cache[cache_filename(name)]
  end

  def of_exercises
    cache[cache_filename('exercises')]
  end

  # - - - - - - - - - - - - - - - - - - - -
  # Used to get start-point from choice

  def of_dirs(name)
    cache[dir_cache_filename(name)]
  end

  private # = = = = = = = = = = = = = = =

  attr_reader :cache

  include MajorName
  include MinorName

  # - - - - - - - - - - - - - - - - - - - -

  def cache_display_names(name)
    display_names,dirs = display_names_and_dirs(name)
    splitter = Splitter.new(display_names)
    cache[cache_filename(name)] =
    {
      major_names:splitter.major_names,
      minor_names:splitter.minor_names,
      minor_indexes:splitter.minor_indexes
    }
    cache[dir_cache_filename(name)] = dirs
  end

  # - - - - - - - - - - - - - - - - - - - -

  def cache_exercises
    cache[cache_filename('exercises')] = exercises
  end

  # - - - - - - - - - - - - - - - - - - - -

  def display_names_and_dirs(sub_dir)
    display_names = []
    dirs = {}
    pattern = "#{start_points_dir}/#{sub_dir}/**/manifest.json"
    Dir.glob(pattern).each do |filename|
      json = JSON.parse(IO.read(filename))
      display_name = json['display_name']
      display_names << display_name
      major_name = major_name(display_name)
      minor_name = minor_name(display_name)
      dirs[major_name] ||= {}
      dirs[major_name][minor_name] = File.dirname(filename)
    end
    [display_names, dirs]
  end

  def start_points_dir
    ENV['CYBER_DOJO_START_POINTS_ROOT']
  end

  # - - - - - - - - - - - - - - - - - - - -

  def exercises
    names = []
    contents =  {}
    pattern = "#{start_points_dir}/exercises/**/instructions"
    Dir.glob(pattern).each do |filename|
      # eg /app/start_points/exercises/Bowling_Game/instructions
      name = filename.split('/')[-2] # eg Bowling_Game
      names << name
      contents[name] = IO.read(filename)
    end
    {
      names:names.sort,
      contents:contents
    }
  end

  # - - - - - - - - - - - - - - - - - - - -

  def dir_cache_filename(name)
    "#{name}_dir_cache.json"
  end

  def cache_filename(name)
    "#{name}_cache.json"
  end

end
