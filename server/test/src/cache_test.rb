require_relative 'test_base'

class CacheTest < TestBase

  def self.hex_prefix
    '3836C'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '446', %w( languages cache ) do
    cache = Cache.new.of_display_names(:languages)
    assert_equal [ 'C (gcc)', 'C#', 'C++ (g++)', 'Python' ], cache[:major_names]
    assert_equal [ 'NUnit', 'assert', 'py.test', 'unittest' ], cache[:minor_names]
    assert_equal [
      [ # 'C (gcc)'
        1, # assert
      ],
      [ # 'C#'
        0, # NUnit
      ],
      [ # 'C++ (g++)'
        1, # assert
      ],
      [ # 'Python'
        2, # py.pytest
        3, # unittest
      ]
    ], cache[:minor_indexes]
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '447', %w( custom cache ) do
    cache = Cache.new.of_display_names('custom')

    assert_equal [ 'Yahtzee refactoring' ], cache[:major_names]

    expected = [ 'C# NUnit', 'C++ (g++) assert', 'Java JUnit', 'Python unitttest' ]
    assert_equal expected, cache[:minor_names]

    expected = [ [0,1,2,3] ]
    assert_equal expected, cache[:minor_indexes]
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '448', %w( exercises cache ) do
    cache = Cache.new.of_exercises

    names = cache[:names]
    assert_equal [ 'Bowling_Game', 'Fizz_Buzz', 'Leap_Years', 'Tiny_Maze' ], names

    hash = cache[:contents]
    assert_equal names, hash.keys.sort

    text = 'Write a program to score a game of Ten-Pin Bowling.'
    assert hash['Bowling_Game'].start_with?(text), hash['Bowling_Game']

    text = 'Write a program that prints the numbers from 1 to 100.'
    assert hash['Fizz_Buzz'].start_with?(text), hash['Fizz_Buzz']

    text = 'Write a function that returns true or false depending on'
    assert hash['Leap_Years'].start_with?(text), hash['Leap_Years']

    text = 'Alice found herself very tiny and wandering around Wonderland.'
    assert hash['Tiny_Maze'].start_with?(text), hash['Tiny_Maze']
  end

end
