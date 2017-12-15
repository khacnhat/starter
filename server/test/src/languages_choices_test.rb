require_relative 'test_base'

class LanguagesChoicesTest < TestBase

  def self.hex_prefix
    '9F544'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '0F4',
  'when kata_id is nil, languages choices have no special index-zero' do
    result = languages_choices(nil)
    expected_major_names = [
      'C#, NUnit',
      'C (gcc), assert',
      'Python, py.test'
    ]
    assert_equal expected_major_names, result['major_list']


  end

end
