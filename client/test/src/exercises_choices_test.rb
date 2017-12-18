require_relative 'test_base'

class ExercisesChoicesTest < TestBase

  def self.hex_prefix
    '1F909'
  end

  # - - - - - - - - - - - - - - - - - - - - -

  test 'AF1', %w( invalid current_exercise_name raises ) do
    [
      42,   # Integer
      [],   # Array
      {},   # Hash
      true, # Boolean
    ].each do |invalid_current_exercise_name|
      error = assert_raises(RuntimeError) {
        exercises_choices(invalid_current_exercise_name)
      }
      expected = 'StarterService:exercises_choices:current_exercise_name:invalid'
      assert_equal expected, error.message
    end
  end

  # - - - - - - - - - - - - - - - - - - - - -

  test 'AF2',
  %w( when current_exercise_name matches an exercise_name
      then index is for matching exercise_name ) do
    @result = exercises_choices('Fizz_Buzz')
    assert_names
    assert_contents
    assert_equal 'Fizz_Buzz', names[index]
  end

  # - - - - - - - - - - - - - - - - - - - -

  test 'AF3',
  %w( when current_exercise_name is nil
      index is random index into names ) do
    assert_random_index(nil)
  end

  # - - - - - - - - - - - - - - - - - - - -

  def names
    @result['names']
  end

  def contents
    @result['contents']
  end

  def index
    @result['index']
  end

  # - - - - - - - - - - - - - - - - - - - -

  def assert_names
    assert_equal ['Bowling_Game', 'Fizz_Buzz', 'Leap_Years', 'Tiny_Maze'], names
  end

  # - - - - - - - - - - - - - - - - - - - -

  def assert_contents
    expected = 'Write a program to score a game of Ten-Pin Bowling.'
    assert_line('Bowling_Game', expected)
    expected = 'Write a program that prints the numbers from 1 to 100.'
    assert_line('Fizz_Buzz', expected)
    expected = 'Write a function that returns true or false depending on '
    assert_line('Leap_Years', expected)
    expected = 'Alice found herself very tiny and wandering around Wonderland.'
    assert_line('Tiny_Maze', expected)
  end

  # - - - - - - - - - - - - - - - - - - - -

  def assert_line(name, expected)
    lines = contents[name].split("\n")
    assert contents[name].start_with?(expected), lines[0]
  end

  # - - - - - - - - - - - - - - - - - - - -

  def assert_random_index(current_exercise_name)
    counts = []
    (1..42).each do
      @result = exercises_choices(current_exercise_name)
      assert_names
      assert_contents
      counts[index] ||= 0
      counts[index] += 1
    end
    assert_equal names.size, counts.size
    (0...counts.size).each do |i|
      assert counts[i] > 0, "#{i}:#{counts[i]}"
    end
  end

end
