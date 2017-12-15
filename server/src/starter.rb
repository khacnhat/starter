require 'json'

class Starter

  def languages_choices(kata_id)
    #kata_id promotes repetition
    #returns a major-names (languages) and a minor-names (testFrameworks)
    #and initial indexes for both lists.

    path = '/app/start_points'
    major_names = []
    minor_names = []
    Dir.glob("#{path}/languages/**/manifest.json").each do |filename|
      json = JSON.parse(IO.read(filename))
      display_name = json['display_name']
      major_name = display_name.split(',')[0].strip
      major_names << major_name
      minor_name = display_name.split(',')[1].strip
      minor_names << minor_name
    end
    major_names = major_names.sort.uniq
    minor_names = minor_names.sort.uniq

    {
      'major_names': major_names,
      'minor_names': minor_names
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

end
