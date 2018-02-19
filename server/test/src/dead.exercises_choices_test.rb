require_relative 'test_base'

class ExercisesChoicesTest < TestBase

  def self.hex_prefix
    'C3339'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '626',%w( exercises_choices ) do
    @result = exercises_choices
    assert_names
    assert_contents
  end

  # - - - - - - - - - - - - - - - - - - - -

  def names
    @result['names']
  end

  def contents
    @result['contents']
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

end
