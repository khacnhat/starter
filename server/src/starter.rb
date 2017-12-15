require 'json'
require_relative 'splitter'

class Starter

  def languages_choices(kata_id)
    #TODO: kata_id promotes repetition
    splitter = Splitter.new(display_names('languages'))
    {
      major_names:splitter.major_names,
      minor_names:splitter.minor_names,
      minor_indexes:splitter.minor_indexes
    }
  end

  # - - - - - - - - - - - - - - - - -

  def exercises_choices(kata_id)
    #kata_id promotes repetition
    #returns a list of exercises
    #and an initial index
  end

  # - - - - - - - - - - - - - - - - -

  def chose_language_exercise(major_name, minor_name, exercise_name)
    #creates a new kata in the storer
    #returns the new kata's hex-id
  end

  # - - - - - - - - - - - - - - - - -
  # - - - - - - - - - - - - - - - - -

  def custom_choices(kata_id)
    #kata_id promotes repetition
    #returns a major-list and a minor-list
    #and initial indexes for both lists
  end

  # - - - - - - - - - - - - - - - - -

  def chose_custom(major_name, minor_name)
    #creates a new kata in the storer
    #returns the new kata's hex-id
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

