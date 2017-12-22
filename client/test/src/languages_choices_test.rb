require_relative 'test_base'

class LanguagesChoicesTest < TestBase

  def self.hex_prefix
    '444EB'
  end

  # - - - - - - - - - - - - - - - - - - - - -

  test '4A9',
  %w( languages_choices ) do
    @result = languages_choices
    assert_equal [ 'C (gcc)', 'C#', 'C++ (g++)', 'Python' ], major_names
    assert_equal [ 'NUnit', 'assert', 'py.test', 'unittest' ], minor_names
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

  private

  def major_names
    @result['major_names']
  end

  def minor_names
    @result['minor_names']
  end

  def minor_indexes
    @result['minor_indexes']
  end

end
