require_relative 'test_base'

class CustomManifestTest < TestBase

  def self.hex_prefix
    'F491E'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '9C1',
  %w( hash with invalid argument becomes exception ) do
    assert_rack_call_raw('custom_manifest',
      '{"major_name":42}',
      { exception:'major_name:invalid' }
    )
    assert_rack_call_raw('custom_manifest',
      '{"major_name":"Yahtzee refactoring","minor_name":42}',
      { exception:'minor_name:invalid' }
    )
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '9C2', %w( invalid major_name becomes exception ) do
    custom_manifest('xxx', 'C# NUnit')
    assert_exception('major_name:invalid')
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '9C3', %w( invalid minor_name becomes exception ) do
    custom_manifest('Yahtzee refactoring', 'xxx')
    assert_exception('minor_name:invalid')
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '9C4',
  %w( valid major_name,minor_name,exercise_name
      returns fully expanded manifest ) do
    result = custom_manifest('Yahtzee refactoring', 'C# NUnit')

    assert_equal 'stateless', result['runner_choice']
    assert_equal 'cyberdojofoundation/csharp_nunit', result['image_name']
    assert_equal 'Yahtzee refactoring, C# NUnit', result['display_name']
    assert_equal '.cs', result['filename_extension']
    assert_equal [], result['progress_regexs']
    assert_equal [], result['highlight_filenames']
    assert_equal default_lowlight_filenames, result['lowlight_filenames']
    assert_equal 10, result['max_seconds']
    assert_equal 4, result['tab_size']

    assert result.key?('id')
    assert result.key?('created')
    assert result.key?('visible_files')
    refute result.key?('visible_filenames')
  end

  # - - - - - - - - - - - - - - - - - - - -

  def default_lowlight_filenames
    [ 'cyber-dojo.sh', 'makefile', 'Makefile', 'unity.license.txt' ]
  end

end