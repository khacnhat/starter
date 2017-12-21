
class ExerciseNameIndexMatcher

  def initialize(cache)
    @cache = cache.of_exercises
  end

  # - - - - - - - - - - - - - - - - -

  def match(current_exercise_name)
    names = cache[:names]
    index = names.index(current_exercise_name)
    if index.nil?
      index = rand(0...names.size)
    end
    {
         names: cache[:names],
      contents: cache[:contents],
         index: index
    }
  end

  private # = = = = = = = = = = = = = = = =

  attr_reader :cache

end
