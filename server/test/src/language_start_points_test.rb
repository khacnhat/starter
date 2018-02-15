require_relative 'test_base'

class LanguagesStartPointsTest < TestBase

  def self.hex_prefix
    'F4DB3'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '0F4',
  %w( display-names are unique and sorted,
      exercise-names are unique and sorted ) do
    @result = languages_exercises_start_points
    assert_display_names
    assert_exercise_names
    assert_exercise_instructions
  end

  # - - - - - - - - - - - - - - - - - - - -

  def assert_display_names
    expected = [
      'C (gcc), assert',
      'C#, NUnit',
      'C++ (g++), assert',
      'Python, py.test',
      'Python, unittest'
    ]
    assert_equal expected, @result['display_names']
  end

  # - - - - - - - - - - - - - - - - - - - -

  def assert_exercise_names
    expected = [
      'Bowling_Game',
      'Fizz_Buzz',
      'Leap_Years',
      'Tiny_Maze'
    ]
    assert_equal expected, @result['exercises'].keys.sort
  end

  # - - - - - - - - - - - - - - - - - - - -

  def assert_exercise_instructions
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
    instructions = @result['exercises'][name]
    lines = instructions.split("\n")
    assert instructions.start_with?(expected), lines[0]
  end

end
