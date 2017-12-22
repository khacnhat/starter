require_relative 'test_base'

class CustomManifestTest < TestBase

  def self.hex_prefix
    'AE7EC'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '3CC',
  %w( valid major_name,minor_name,exercise_name
      returns fully expanded manifest ) do
    result = custom_manifest('Yahtzee refactoring', 'Java JUnit')

    assert_equal 'stateless', result['runner_choice']
    assert_equal 'cyberdojofoundation/java_junit', result['image_name']
    assert_equal 'Yahtzee refactoring, Java JUnit', result['display_name']
    assert_equal '.java', result['filename_extension']
    assert_equal [], result['progress_regexs']
    assert_equal [], result['highlight_filenames']
    assert_equal default_lowlight_filenames, result['lowlight_filenames']
    assert_equal 10, result['max_seconds']
    assert_equal 4, result['tab_size']

    assert result.key?('visible_files')
    refute result.key?('visible_filenames')
  end

  # - - - - - - - - - - - - - - - - - - - -

  def default_lowlight_filenames
    [ 'cyber-dojo.sh', 'makefile', 'Makefile', 'unity.license.txt' ]
  end

end