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
  %w( valid with one optional property ) do
    manifest = custom_manifest('Yahtzee refactoring', 'C# NUnit')

    expected_keys = %w(
      display_name image_name runner_choice visible_files
      filename_extension
    )
    assert_equal expected_keys.sort, manifest.keys.sort

    assert_equal 'Yahtzee refactoring, C# NUnit', manifest['display_name']
    assert_equal '.cs', manifest['filename_extension']
    assert_equal 'cyberdojofoundation/csharp_nunit', manifest['image_name']
    assert_equal 'stateless', manifest['runner_choice']
    expected_filenames = %w( Yahtzee.cs YahtzeeTest.cs cyber-dojo.sh instructions output )
    assert_equal expected_filenames, manifest['visible_files'].keys.sort
  end

end