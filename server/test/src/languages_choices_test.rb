require_relative 'test_base'

class LanguagesChoicesTest < TestBase

  def self.hex_prefix
    '9F544'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '0F4',
  %w( major-names (languages) are unique and sorted
      minor-names (testFrameworks) are unique and sorted ) do

    result = languages_choices(nil)

    expected_major_names = [ 'C (gcc)', 'C#', 'C++ (g++)', 'Python' ]
    assert_equal expected_major_names, result['major_names']

    expected_minor_names = [ 'NUnit', 'assert', 'py.test', 'unittest' ]
    assert_equal expected_minor_names, result['minor_names']


  end

end
