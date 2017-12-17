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

  test 'D7B', %w( invalid display_name raises ) do
    language_manifest('x,y', 'Fizz_Buzz')
    assert_exception('display_name:invalid')
  end

  # - - - - - - - - - - - - - - - - - - - -

  test 'D7C', %w( invalid exercise_name raises ) do
    language_manifest('C#, NUnit', 'xxx')
    assert_exception('exercise_name:invalid')
  end

  # - - - - - - - - - - - - - - - - - - - -

  test 'D7D', %w( valid display_name raises ) do
    result = language_manifest('C#, NUnit', 'Fizz_Buzz')

    assert_equal 'stateless', result['runner_choice']
    assert_equal 'cyberdojofoundation/csharp_nunit', result['image_name']
    assert_equal 'C#, NUnit', result['display_name']
    assert_equal '.cs', result['filename_extension']
    assert result.key?('progress_regexs')
    assert_equal [], result['highlight_filenames']
    assert result.key?('lowlight_filenames')
    assert_equal 'C#-NUnit', result['language']
    assert_equal 10, result['max_seconds']
    assert_equal 4, result['tab_size']
    assert result.key?('visible_files')
    refute result.key?('visible_filenames')
    assert_equal 'Fizz_Buzz', result['exercise']
  end

  # - - - - - - - - - - - - - - - - - - - -

  test 'D7E', %w( explicit highlight_filenames ) do
    result = language_manifest('Python, unittest', 'Fizz_Buzz')
    assert_equal [ 'test_hiker.py' ], result['highlight_filenames']
    assert_equal [ "cyber-dojo.sh", "hiker.py" ], result['lowlight_filenames'].sort
  end

  # - - - - - - - - - - - - - - - - - - - -


end