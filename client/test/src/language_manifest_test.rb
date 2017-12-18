require_relative 'test_base'

class LanguageManifestTest < TestBase

  def self.hex_prefix
    'D4735'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '266',
  %w( valid major_name,minor_name,exercise_name
      returns fully expanded manifest ) do
    result = language_manifest('C#', 'NUnit', 'Fizz_Buzz')

    assert_equal 'stateless', result['runner_choice']
    assert_equal 'cyberdojofoundation/csharp_nunit', result['image_name']
    assert_equal 'C#, NUnit', result['display_name']
    assert_equal '.cs', result['filename_extension']
    assert_equal [], result['progress_regexs']
    assert_equal [], result['highlight_filenames']
    assert_equal default_lowlight_filenames, result['lowlight_filenames']
    assert_equal 'C#-NUnit', result['language']
    assert_equal 10, result['max_seconds']
    assert_equal 4, result['tab_size']
    assert_equal 'Fizz_Buzz', result['exercise']

    assert result.key?('visible_files')
    refute result.key?('visible_filenames')
  end

  # - - - - - - - - - - - - - - - - - - - -

  def default_lowlight_filenames
    [ 'cyber-dojo.sh', 'makefile', 'Makefile', 'unity.license.txt' ]
  end

end