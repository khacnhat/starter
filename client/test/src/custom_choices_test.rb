require_relative 'test_base'

class CustomChoicesTest < TestBase

  def self.hex_prefix
    '9E66D'
  end

  # - - - - - - - - - - - - - - - - - - - - -

  test '90A', %w( invalid current_display_name raises ) do
    [
      42,   # Integer
      [],   # Array
      {},   # Hash
      true, # Boolean
    ].each do |invalid_current_display_name|
      error = assert_raises(RuntimeError) {
        custom_choices(invalid_current_display_name)
      }
      expected = 'StarterService:custom_choices:current_display_name:invalid'
      assert_equal expected, error.message
    end
  end

  # - - - - - - - - - - - - - - - - - - - - -

  test '90B',
  %w( custom_choices ) do
    @result = custom_choices('Yahtzee refactoring, Java JUnit')
    assert_major_names
    assert_equal 0, major_index
    assert_equal 'Yahtzee refactoring', major_names[major_index]
    assert_minor_names
    assert_equal [[2,0,1,3]], minor_indexes
    assert_equal 'Java JUnit', minor_names[minor_indexes[major_index][0]]
  end

  private # = = = = = = = = = = = = = = = =

  def major_names
    @result['major_names']
  end

  def major_index
    @result['major_index']
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
