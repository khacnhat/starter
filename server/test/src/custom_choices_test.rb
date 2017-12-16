require_relative 'test_base'

class CustomChoicesTest < TestBase

  def self.hex_prefix
    '5F36E'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '1B4', %w( invalid current_display_name raises ) do
    [
      42,   # Integer
      [],   # Array
      {},   # Hash
      true, # Boolean
    ].each do |invalid_current_display_name|
      custom_choices(invalid_current_display_name)
      assert_exception('current_display_name:invalid')
    end
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '1B5',
  %w( major-names,minor-names are unique and sorted,
      minor-indexes can reconstitute the display_names ) do
    @result = custom_choices(nil)
    assert_major_names
    assert_minor_names
    assert_minor_indexes
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '1B6',
  %w( when current_display_name is nil
      initial_index is random index into major_names
      and minor_indexes are not 0-altered ) do
    assert_random_initial_index(nil)
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '0F2',
  %w( when current_display_name's major_name does not match any major_name
      initial_index is random index into major_names
      and minor_indexes are not 0-altered ) do
    assert_random_initial_index('C++ Countdown, Java JUnit')
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '0F3',
  %w( when current_display_name's major_name matches a major_name
      but current_display_name's minor_name does not match a minor_name
      then initial_index is for matching major_name
      and minor_indexes are not 0-altered ) do
    @result = custom_choices('Yahtzee refactoring, C# Moq')
    assert_major_names
    assert_minor_names
    assert_minor_indexes
    assert_equal 'Yahtzee refactoring', major_names[initial_index]
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '0F5',
  %w( when current_display_name matches a major_name and a minor_name
      then initial_index is matching for major_name
      and its minor_index at position zero is matching for the minor_name ) do
    @result = custom_choices('Yahtzee refactoring, Java JUnit')
    assert_major_names
    assert_minor_names
    assert_equal 'Yahtzee refactoring', major_names[initial_index]
    assert_equal 'Java JUnit', minor_names[minor_indexes[initial_index][0]]
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

  def initial_index
    @result['initial_index']
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

  # - - - - - - - - - - - - - - - - - - - -

  def assert_random_initial_index(current_display_name)
    counts = []
    (1..42).each do
      @result = custom_choices(current_display_name)
      assert_major_names
      assert_minor_names
      assert_minor_indexes
      counts[initial_index] ||= 0
      counts[initial_index] += 1
    end
    assert_equal major_names.size, counts.size
    (0...counts.size).each do |i|
      assert counts[i] > 0, "#{i}:#{counts[i]}"
    end
  end

end
