require_relative 'test_base'

class LanguagesChoicesTest < TestBase

  def self.hex_prefix
    '444EB'
  end

  # - - - - - - - - - - - - - - - - - - - - -

  test '4A2', %w( invalid current_display_name raises ) do
    [
      42,   # Integer
      [],   # Array
      {},   # Hash
      true, # Boolean
    ].each do |invalid_current_display_name|
      error = assert_raises(RuntimeError) {
        languages_choices(invalid_current_display_name)
      }
      expected = 'StarterService:languages_choices:current_display_name:invalid'
      assert_equal expected, error.message
    end
  end

  # - - - - - - - - - - - - - - - - - - - - -

  test '4A9',
  %w( languages_choices ) do
    @result = languages_choices('Python, pytest')
    assert_equal [ 'C (gcc)', 'C#', 'C++ (g++)', 'Python' ], major_names
    assert_equal 3, major_index
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

  def major_index
    @result['major_index']
  end

  def minor_indexes
    @result['minor_indexes']
  end

end
