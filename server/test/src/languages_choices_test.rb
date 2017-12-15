require_relative 'test_base'

class LanguagesChoicesTest < TestBase

  def self.hex_prefix
    '9F544'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '0F0', %w( invalid display_name raises ) do
    [
      42,   # Integer
      [],   # Array
      {},   # Hash
      true, # Boolean
    ].each do |invalid_display_name|
      languages_choices(invalid_display_name)
      assert_exception('display_name:invalid')
    end
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '0F4',
  %w( major-names (languages) are unique and sorted,
      minor-names (testFrameworks) are unique and sorted,
      minor-indexes can reconstitute the display_names ) do

    result = languages_choices(nil)

    expected_major_names = [ 'C (gcc)', 'C#', 'C++ (g++)', 'Python' ]
    assert_equal expected_major_names, result['major_names']

    expected_minor_names = [ 'NUnit', 'assert', 'py.test', 'unittest' ]
    assert_equal expected_minor_names, result['minor_names']

    expected_minor_indexes =[
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
    assert_equal expected_minor_indexes, result['minor_indexes']
  end

  # - - - - - - - - - - - - - - - - - - - -


end
