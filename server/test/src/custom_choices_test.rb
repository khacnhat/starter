require_relative 'test_base'

class CustomChoicesTest < TestBase

  def self.hex_prefix
    '5F36E'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '1B5',
  %w( major-names,minor-names are unique and sorted,
      minor-indexes can reconstitute the display_names ) do
    @result = custom_choices
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
    assert_equal [ 'Yahtzee refactoring' ], major_names
  end

  def assert_minor_names
    assert_equal [ 'C# NUnit', 'C++ (g++) assert', 'Java JUnit', 'Python unitttest' ], minor_names
  end

  def assert_minor_indexes
    expected_minor_indexes = [
      [ # 'Yahtzee refactoring'
        0,1,2,3
      ]
    ]
    assert_equal expected_minor_indexes, minor_indexes
  end

end
