require_relative 'test_base'

class LanguageManifestTest < TestBase

  def self.hex_prefix
    '3D915'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test 'D7A',
  %w( hash with invalid argument becomes exception ) do
    assert_rack_call_raw('language_manifest',
      '{"display_name":42}',
      { exception:'display_name:invalid' }
    )
    assert_rack_call_raw('language_manifest',
      '{"display_name":"C#,NUnit","exercise_name":42}',
      { exception:'exercise_name:invalid' }
    )
  end

  # - - - - - - - - - - - - - - - - - - - -

  test 'D7B', %w( invalid display_name becomes exception ) do
    language_manifest('x,y', 'Fizz_Buzz')
    assert_exception('display_name:invalid')
  end

  # - - - - - - - - - - - - - - - - - - - -

  test 'D7C', %w( invalid exercise_name becomes exception ) do
    language_manifest('C#, NUnit', 'xxx')
    assert_exception('exercise_name:invalid')
  end

  # - - - - - - - - - - - - - - - - - - - -

  test 'D7D',
  %w( valid display_name and exercise_name
      returns fully expanded manifest ) do
    result = language_manifest('C#, NUnit', 'Fizz_Buzz')

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

  test 'D7E', %w( start-point with explicit opional properties ) do
    result = language_manifest('Python, unittest', 'Fizz_Buzz')
    assert_equal [ 'test_hiker.py' ], result['highlight_filenames']
    assert_equal [ "cyber-dojo.sh", "hiker.py" ], result['lowlight_filenames'].sort
    assert_equal 11, result['max_seconds']
    assert_equal 3, result['tab_size']
    assert_equal [ 'FAILED \\(failures=\\d+\\)', 'OK' ], result['progress_regexs']
  end

  # - - - - - - - - - - - - - - - - - - - -

  def default_lowlight_filenames
    [ 'cyber-dojo.sh', 'makefile', 'Makefile', 'unity.license.txt' ]
  end

end