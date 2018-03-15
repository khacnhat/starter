require 'json'
require_relative 'renamer'

class Starter

  def initialize
    @cache = {}

    @cache['languages'] = {
      'display_names' => display_names('languages'),
      'manifests'     => manifests('languages'),
      'exercises'     => exercises
    }
    @cache['custom'] = {
      'display_names' => display_names('custom'),
      'manifests'     => manifests('custom')
    }
  end

  # - - - - - - - - - - - - - - - - -
  # setting up a cyber-dojo: language,testFramwork + exercise
  # - - - - - - - - - - - - - - - - -

  def language_start_points
    {
      'languages' => cache['languages']['display_names'],
      'exercises' => cache['languages']['exercises']
    }
  end

  def language_manifest(display_name, exercise_name)
    assert_string('display_name', display_name)
    assert_string('exercise_name', exercise_name)
    {
      'manifest' => cached_manifest('languages', display_name),
      'exercise' => cached_exercise(exercise_name)
    }
  end

  # - - - - - - - - - - - - - - - - -
  # setting up a cyber-dojo: custom
  # - - - - - - - - - - - - - - - - -

  def custom_start_points
    cache['custom']['display_names']
  end

  def custom_manifest(display_name)
    assert_string('display_name', display_name)
    cached_manifest('custom', display_name)
  end

  # - - - - - - - - - - - - - - - - -
  # update and old manifest
  # - - - - - - - - - - - - - - - - -

  def updated_manifest(manifest)
    assert_hash('manifest', manifest)
    if manifest['unit_test_framework']
      change_1_removed_unit_test_framework(manifest)
    end
    if manifest['runner_choice'].nil?
      change_2_added_runner_choice(manifest)
    end
    manifest
  end

  private # = = = = = = = = = = = = =

  def change_1_removed_unit_test_framework(manifest)
    # removed manifest['unit_test_framework'] property
    # removed manifest['language] property
    # These coupled a manifest to a start-point
    # Better for the manifest to be self-contained
    xlated = xlate(manifest['language'].split('-', 2))
    manifest['display_name'] = xlated['display_name']
    manifest['image_name'] = xlated['image_name']
    manifest.delete('language')
    manifest.delete('unit_test_framework')
    # 'browser' is no longer needed or used
    manifest.delete('browser')
  end

  # - - - - - - - - - - - - - - - - -

  def change_2_added_runner_choice(manifest)
    # added manifest['runner_choice'] property
    xlated = xlate(manifest['display_name'].split(', '))
    manifest['runner_choice'] = xlated['runner_choice']
  end

  # - - - - - - - - - - - - - - - - -

  def xlate(parts)
    parts = Renamer.new.renamed(parts.map(&:strip))
    display_name = parts.join(', ')
    cached_manifest('languages', display_name)
  end

  # - - - - - - - - - - - - - - - - -

  def method_missing(name, *_args, &_block)
    raise RuntimeError.new("#{name}:unknown_method")
  end

  # - - - - - - - - - - - - - - - - -

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
    Dir.glob(pattern).each do |manifest_filename|
      manifest = JSON.parse(IO.read(manifest_filename))
      display_name = manifest['display_name']
      visible_filenames = manifest['visible_filenames']
      dir = File.dirname(manifest_filename)
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

  def cached_manifest(type, display_name)
    result = cache[type]['manifests'][display_name]
    if result.nil?
      error('display_name', "#{display_name}:unknown")
    end
    result
  end

  def cached_exercise(exercise_name)
    result = cache['languages']['exercises'][exercise_name]
    if result.nil?
      error('exercise_name', "#{exercise_name}:unknown")
    end
    result
  end

  # - - - - - - - - - - - - - - - - - - - -

  def start_points_dir
    ENV['CYBER_DOJO_START_POINTS_ROOT']
  end

  # - - - - - - - - - - - - - - - - - - - -

  def assert_string(arg_name, arg)
    unless arg.is_a?(String)
      error(arg_name, '!string')
    end
  end

  # - - - - - - - - - - - - - - - - - - - -

  def assert_hash(arg_name, arg)
    unless arg.is_a?(Hash)
      error(arg_name, '!Hash')
    end
  end

  # - - - - - - - - - - - - - - - - - - - -

  def error(name, diagnostic)
    raise ArgumentError.new("#{name}:#{diagnostic}")
  end

end
