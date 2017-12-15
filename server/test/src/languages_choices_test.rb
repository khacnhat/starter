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
    @result = languages_choices(nil)
    assert_major_names
    assert_minor_names
    assert_minor_indexes
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '0F1',
  %w( when recent_display_name is nil
      initial_index is random index into major_names ) do
    assert_random_initial_index(nil)
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '0F2',
  %w( when recent_display_name's major_name does not match any major_name
      initial_index is random index into major_names ) do
    assert_random_initial_index('Java, JUnit')
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '0F3',
  %w( when recent_display_name's major_name matches a major_name
      but recent_display_name's minor_name does not match a minor_name
      then initial_index is for matching major_name
      and minor_indexes are not 0-altered ) do
    @result = languages_choices('C#, Moq')
    assert_major_names
    assert_minor_names
    assert_minor_indexes
    assert_equal 'C#', major_names[initial_index]
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '0F5',
  %w( when recent_display_name matches a major_name and a minor_name
      then initial_index is matching for major_name
      and its minor_index at position zero os matching for the minor_name ) do
    @result = languages_choices('Python, unittest')
    assert_major_names
    assert_minor_names
    assert_equal 'Python', major_names[initial_index]
    assert_equal 'unittest', minor_names[minor_indexes[initial_index][0]]
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
    assert_equal [ 'C (gcc)', 'C#', 'C++ (g++)', 'Python' ], major_names
  end

  def assert_minor_names
    assert_equal [ 'NUnit', 'assert', 'py.test', 'unittest' ], minor_names
  end

  def assert_minor_indexes
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
    assert_equal expected_minor_indexes, minor_indexes
  end

  # - - - - - - - - - - - - - - - - - - - -

  def assert_random_initial_index(recent_display_name)
    counts = []
    (1..42).each do
      @result = languages_choices(recent_display_name)
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
