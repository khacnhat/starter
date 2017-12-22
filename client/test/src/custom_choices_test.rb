require_relative 'test_base'

class CustomChoicesTest < TestBase

  def self.hex_prefix
    '9E66D'
  end

  # - - - - - - - - - - - - - - - - - - - - -

  test '90B',
  %w( custom_choices ) do
    @result = custom_choices
    assert_major_names
    assert_minor_names
    assert_equal [[0,1,2,3]], minor_indexes
  end

  private # = = = = = = = = = = = = = = = =

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

end
