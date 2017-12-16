require 'json'
require 'fileutils'
require_relative 'splitter'

class Cacher

  def initialize
    FileUtils.mkdir_p(cache_dir)
  end

  # - - - - - - - - - - - - - - - - - - - -

  def write_display_names_cache(name)
    splitter = Splitter.new(display_names(name))
    cache = {
      major_names:splitter.major_names,
      minor_names:splitter.minor_names,
      minor_indexes:splitter.minor_indexes
    }
    IO.write(cache_filename(name), JSON.unparse(cache))
  end

  # - - - - - - - - - - - - - - - - - - - -

  def read_display_names_cache(name)
    JSON.parse(IO.read(cache_filename(name)))
  end

  # - - - - - - - - - - - - - - - - - - - -

  def write_exercises_cache
    IO.write(cache_filename('exercises'), JSON.unparse(exercises))
  end

  def read_exercises_cache
    JSON.parse(IO.read(cache_filename('exercises')))
  end

  private # = = = = = = = = = = = = = = =

  def display_names(sub_dir)
    result = []
    pattern = "#{start_points_dir}/#{sub_dir}/**/manifest.json"
    Dir.glob(pattern).each do |filename|
      json = JSON.parse(IO.read(filename))
      result << json['display_name']
    end
    result
  end

  def start_points_dir
    ENV['CYBER_DOJO_START_POINTS_ROOT']
  end

  # - - - - - - - - - - - - - - - - - - - -

  def exercises
    names = []
    hash =  {}
    pattern = "#{start_points_dir}/exercises/**/instructions"
    Dir.glob(pattern).each do |filename|
      # eg /app/start_points/exercises/Bowling_Game/instructions
      name = filename.split('/')[-2] # eg Bowling_Game
      names << name
      hash[name] = IO.read(filename)
    end
    [names.sort, hash]
  end

  # - - - - - - - - - - - - - - - - - - - -

  def cache_filename(name)
    "#{cache_dir}/#{name}_cache.json"
  end

  def cache_dir
    '/tmp/starter'
  end

end
