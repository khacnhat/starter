
require_relative '../../src/rack_dispatcher'
require_relative 'rack_request_stub'
require_relative 'test_base'

class RackDispatcherTest < TestBase

  def self.hex_prefix
    'D06F7'
  end

  # - - - - - - - - - - - - - - - - -

  test 'BB0',
  %w( unknown method-name becomes exception ) do
    assert_rack_call_raw('blah',              '{}', {
      exception:'blah:unknown_method' }
    )
    assert_rack_call_raw('Languages_choices', '{}', {
      exception:'Languages_choices:unknown_method' }
    )
    assert_rack_call_raw('a b', '{}', {
      exception:'a b:unknown_method' }
    )
  end

  # - - - - - - - - - - - - - - - - -

  test 'BB1',
  %w( invalid json in http payload becomes exception ) do
    assert_rack_call_raw('languages_choices', 'sdfsdf', { exception:'json:invalid' })
    assert_rack_call_raw('languages_choices', 'nil',    { exception:'json:invalid' })
  end

  # - - - - - - - - - - - - - - - - -

  test 'BB2',
  %w( non-hash in http payload becomes exception ) do
    assert_rack_call_raw('languages_choices', 'null',   { exception:'json:!Hash' })
    assert_rack_call_raw('languages_choices', '[]',     { exception:'json:!Hash' })
  end

  # - - - - - - - - - - - - - - - - -

  test 'BB3',
  %w( hash without key for parameter-name becomes excecption ) do
    assert_rack_call_raw('languages_choices', '{}', { exception:'display_name:missing' })
  end

  # - - - - - - - - - - - - - - - - -

  def assert_rack_call_raw(path_info, args, expected)
    rack = RackDispatcher.new(RackRequestStub)
    env = { body:args, path_info:path_info }
    tuple = rack.call(env)
    assert_equal 200, tuple[0]
    assert_equal({ 'Content-Type' => 'application/json' }, tuple[1])
    assert_equal [ expected.to_json ], tuple[2]
  end

end

