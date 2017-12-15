
class Starter

  def languages_choices(kata_id)
    #kata_id promotes repetition
    #returns a major-list (languages) and a minor-list (testFrameworks)
    #and initial indexes for both lists.
    {
      'major_list': [
        'a','b','c'
      ]
    }
  end

  def exercises_choices(kata_id)
    #kata_id promotes repetition
    #returns a list of exercises
    #and an initial index
  end

  def chose_language_exercise(major_name, minor_name, exercise_name)
    #creates a new kata in the storer
    #returns the new kata's hex-id
  end

  # - - - - - - - - - - - - - - - - -

  def custom_choices(kata_id)
    #kata_id promotes repetition
    #returns a major-list and a minor-list
    #and initial indexes for both lists
  end

  def chose_custom(major_name, minor_name)
    #creates a new kata in the storer
    #returns the new kata's hex-id
  end

end
