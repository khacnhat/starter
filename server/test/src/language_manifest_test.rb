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

  test 'D7B', %w( invalid current_display_name raises ) do
    result = language_manifest('C#, NUnit', 'Fizz_Buzz')

    assert_equal 'stateless', result['runner_choice']
    assert_equal 'cyberdojofoundation/csharp_nunit', result['image_name']
    assert_equal 'C#, NUnit', result['display_name']
    assert_equal '.cs', result['filename_extension']
    assert result.key?('progress_regexs')
    assert_equal [], result['highlight_filenames']
    # 'lowlight_filenames'
    # 'name'
    assert_equal 10, result['max_seconds']
    assert_equal 4, result['tab_size']
    assert result.key?('visible_files')
    refute result.key?('visible_filenames')
  end

  # - - - - - - - - - - - - - - - - - - - -


end