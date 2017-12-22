require_relative 'test_base'

class LanguagesChoicesTest < TestBase

  def self.hex_prefix
    '9F544'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '0F4',
  %w( major-names (languages) are unique and sorted,
      minor-names (testFrameworks) are unique and sorted,
      minor-indexes can reconstitute the display_names ) do
    @result = languages_choices
    assert_major_names
    assert_minor_names
    assert_minor_indexes
  end

  # - - - - - - - - - - - - - - - - - - - -

  def major_names
    @result['major_names']
  end

  def minor_names
    @result['minor_names']
  end

  def minor_indexes
    @result['minor_indexes']
  end

  # - - - - - - - - - - - - - - - - - - - -

  def assert_major_names
    assert_equal [ 'C (gcc)', 'C#', 'C++ (g++)', 'Python' ], major_names
  end

  def assert_minor_names
    assert_equal [ 'NUnit', 'assert', 'py.test', 'unittest' ], minor_names
  end

  def assert_minor_indexes
    expected_minor_indexes = [
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
    ]
    assert_equal expected_minor_indexes, minor_indexes
  end

end
