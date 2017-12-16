require_relative 'test_base'

class CacherTest < TestBase

  def self.hex_prefix
    '3836C'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '446', %w( languages cache ) do
    cacher = Cacher.new
    cacher.write_display_names_cache('languages')
    cache = cacher.read_display_names_cache('languages')
    assert_equal [ 'C (gcc)', 'C#', 'C++ (g++)', 'Python' ], cache['major_names']
    assert_equal [ 'NUnit', 'assert', 'py.test', 'unittest' ], cache['minor_names']
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
    ], cache['minor_indexes']
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '447', %w( custom cache ) do
    cacher = Cacher.new
    cacher.write_display_names_cache('custom')
    cache = cacher.read_display_names_cache('custom')

    assert_equal [ 'Yahtzee refactoring' ], cache['major_names']

    expected = [ 'C# NUnit', 'C++ (g++) assert', 'Java JUnit', 'Python unitttest' ]
    assert_equal expected, cache['minor_names']

    expected = [ [0,1,2,3] ]
    assert_equal expected, cache['minor_indexes']
  end

end
