require 'json'
require 'fileutils'
require_relative 'splitter'

class Cacher

  def initialize
    FileUtils.mkdir_p(cache_dir)
  end

  def write_display_names_cache(name)
    splitter = Splitter.new(display_names(name))
    cache = {
      major_names:splitter.major_names,
      minor_names:splitter.minor_names,
      minor_indexes:splitter.minor_indexes
    }
    IO.write(cache_filename(name), JSON.unparse(cache))
  end

  def read_display_names_cache(name)
    JSON.parse(IO.read(cache_filename(name)))
  end

  private

  def cache_dir
    '/tmp/starter'
  end

  def cache_filename(name)
    "#{cache_dir}/#{name}_cache.json"
  end

  def start_points_dir
    ENV['CYBER_DOJO_START_POINTS_ROOT']
  end

  def display_names(sub_dir)
    result = []
    pattern = "#{start_points_dir}/#{sub_dir}/**/manifest.json"
    Dir.glob(pattern).each do |filename|
      json = JSON.parse(IO.read(filename))
      result << json['display_name']
    end
    result
  end

end
