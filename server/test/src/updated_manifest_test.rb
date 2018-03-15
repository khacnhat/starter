require_relative 'test_base'

class UpdatedManifestTest < TestBase

  def self.hex_prefix
    '02186'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '350', %w( invalid argument raises ) do
    expected = { 'exception' => 'manifest:!Hash' }
    assert_rack_call_raw(
      'updated_manifest',
      '{ "manifest": 42 }',
      expected
    )
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '351', %w( change #1
  given a old manifest with a 'language' property
  then it always also has a 'unit_test_framework' property
  and both are removed
  and the corresponding 'display_name' property is added
  and the corresponding 'image_name' property is added
  and the corresponding 'runner_choice' property is added
  and also the 'browser' property is removed if present
  ) do
    manifest = updated_manifest({
      'language' => 'C#-NUnit',
      'unit_test_framework' => 'csharp_nunit',
      'browser' => 'blah blah'
    })
    expected_keys = %w( display_name image_name runner_choice )
    assert_equal expected_keys, manifest.keys.sort
    assert_equal 'C#, NUnit', manifest['display_name']
    assert_equal 'cyberdojofoundation/csharp_nunit', manifest['image_name']
    assert_equal 'stateless', manifest['runner_choice']
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '352', %w( change #2
  given an old manifest without a 'runner_choice' property
  then the 'runner_choice' property is added
  ) do
    display_name = 'C#, NUnit'
    manifest = updated_manifest({
      'display_name' => display_name
    })
    expected_keys = %w( display_name runner_choice )
    assert_equal display_name, manifest['display_name']
    assert_equal 'stateless', manifest['runner_choice']
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '353', %w( up-to-date manifest is unchanged ) do
    manifest = {
      'display_name' => 'C#, NUnit',
      'runner_choice' => 'stateless'
    }
    assert_equal manifest, updated_manifest(manifest)
  end

  # - - - - - - - - - - - - - - - - - - - -


  test '354', %w( old 'language' that maps simply ) do
    manifest = updated_manifest({
      'language' => 'C (gcc)-assert',
      'unit_test_framework' => 'c_assert'
    })
    assert_equal 'C (gcc), assert', manifest['display_name']
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '355', %w( old 'language' that maps via rename ) do
    manifest = updated_manifest({
      'language' => 'C (gcc)-assert',
      'unit_test_framework' => 'c_assert'
    })
    assert_equal 'C (gcc), assert', manifest['display_name']
  end

end