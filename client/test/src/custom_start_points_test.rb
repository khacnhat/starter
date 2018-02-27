require_relative 'test_base'

class CustomStartPointsTest < TestBase

  def self.hex_prefix
    '9E66D'
  end

  # - - - - - - - - - - - - - - - - - - - - -

  test '9C1',
  %w( display-names are unique and sorted ) do
    start_points = custom_start_points
    expected = [
      'Yahtzee refactoring, C# NUnit',
      'Yahtzee refactoring, C++ (g++) assert',
      'Yahtzee refactoring, Java JUnit',
      'Yahtzee refactoring, Python unitttest'
    ]
    assert_equal expected, start_points
  end

end
