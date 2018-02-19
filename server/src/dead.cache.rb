require 'json'

class Cache

  def initialize
    @cache = {}

    @cache['languages'] = {
      'display_names' => display_names('languages'),
      'manifests'     => manifests('languages')
    }
    @cache['exercises'] = exercises

    @cache['custom'] = {
      'display_names' => display_names('custom'),
      'manifests'     => manifests('custom')
    }
  end

  # - - - - - - - - - - - - - - - - - - - -

  def [](name)
    @cache[name]
  end

  private # = = = = = = = = = = = = = = =

  attr_reader :cache

  def display_names(sub_dir)
    display_names = []
    pattern = "#{start_points_dir}/#{sub_dir}/**/manifest.json"
    Dir.glob(pattern).each do |filename|
      json = JSON.parse(IO.read(filename))
      display_names << json['display_name']
    end
    display_names.sort
  end

  def manifests(sub_dir)
    manifests = {}
    pattern = "#{start_points_dir}/#{sub_dir}/**/manifest.json"
    Dir.glob(pattern).each do |filename|
      manifest = JSON.parse(IO.read(filename))
      display_name = manifest['display_name']
      visible_filenames = manifest['visible_filenames']
      dir = File.dirname(filename)
      manifest['visible_files'] =
        Hash[visible_filenames.collect { |filename|
          [filename, IO.read("#{dir}/#{filename}")]
        }]
      manifest['visible_files']['output'] = ''
      manifest.delete('visible_filenames')
      manifests[display_name] = manifest
    end
    manifests
  end

  # - - - - - - - - - - - - - - - - - - - -

  def exercises
    result = {}
    pattern = "#{start_points_dir}/exercises/**/instructions"
    Dir.glob(pattern).each do |filename|
      # eg /app/start_points/exercises/Bowling_Game/instructions
      name = filename.split('/')[-2] # eg Bowling_Game
      result[name] = IO.read(filename)
    end
    result
  end

  # - - - - - - - - - - - - - - - - - - - -

  def start_points_dir
    ENV['CYBER_DOJO_START_POINTS_ROOT']
  end

end
