require 'json'
require 'fileutils'
require_relative 'splitter'

class Cacher

  def initialize
    FileUtils.mkdir_p(cache_dir)
  end

  # - - - - - - - - - - - - - - - - - - - -

  def write_display_names_caches(name)
    display_names,dirs = display_names_dirs(name)
    splitter = Splitter.new(display_names)
    cache = JSON.unparse({
      major_names:splitter.major_names,
      minor_names:splitter.minor_names,
      minor_indexes:splitter.minor_indexes
    })
    IO.write(cache_filename(name), cache)
    IO.write(dir_cache_filename(name), JSON.unparse(dirs))
  end

  # - - - - - - - - - - - - - - - - - - - -

  def read_display_names_cache(name)
    cache = IO.read(cache_filename(name))
    JSON.parse(cache)
  end

  # - - - - - - - - - - - - - - - - - - - -

  def read_dir_cache(name)
    cache = IO.read(dir_cache_filename(name))
    JSON.parse(cache)
  end

  # - - - - - - - - - - - - - - - - - - - -

  def write_exercises_cache
    cache = JSON.unparse(exercises)
    IO.write(cache_filename('exercises'), cache)
  end

  # - - - - - - - - - - - - - - - - - - - -

  def read_exercises_cache
    cache = IO.read(cache_filename('exercises'))
    JSON.parse(cache)
  end

  private # = = = = = = = = = = = = = = =

  def display_names_dirs(sub_dir)
    display_names = []
    dirs = {}
    pattern = "#{start_points_dir}/#{sub_dir}/**/manifest.json"
    Dir.glob(pattern).each do |filename|
      json = JSON.parse(IO.read(filename))
      display_name = json['display_name']
      display_names << display_name
      dirs[display_name] = File.dirname(filename)
    end
    [display_names, dirs]
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
    {
      names:names.sort,
      contents:hash
    }
  end

  # - - - - - - - - - - - - - - - - - - - -

  def dir_cache_filename(name)
    "#{cache_dir}/#{name}_dir_cache.json"
  end

  def cache_filename(name)
    "#{cache_dir}/#{name}_cache.json"
  end

  def cache_dir
    '/tmp/starter'
  end

end
