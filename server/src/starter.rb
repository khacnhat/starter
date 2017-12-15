require 'json'
require_relative 'splitter'

class Starter

  def languages_choices(display_name)
    splitter = Splitter.new(display_names('languages'), display_name)
    {
      major_names:splitter.major_names,
      minor_names:splitter.minor_names,
      minor_indexes:splitter.minor_indexes,
      initial_index:splitter.initial_index
    }
  end

  # - - - - - - - - - - - - - - - - -

  def exercises_choices(exercise_name)
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

  private # = = = = = = = = = = = = =

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

