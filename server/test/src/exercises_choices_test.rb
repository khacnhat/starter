require_relative 'test_base'

class ExercisesChoicesTest < TestBase

  def self.hex_prefix
    'C3339'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '625', %w( invalid exercise_name raises ) do
    [
      42,   # Integer
      [],   # Array
      {},   # Hash
      true, # Boolean
    ].each do |invalid_exercise_name|
      exercises_choices(invalid_exercise_name)
      assert_exception('current_exercise_name:invalid')
    end
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '626',%w( exercises_choices ) do
    @result = exercises_choices(nil)
    #TODO
  end

end
