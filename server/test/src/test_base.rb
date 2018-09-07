require_relative 'hex_mini_test'
require_relative 'rack_request_stub'
require_relative '../../src/rack_dispatcher'
require 'json'

class TestBase < HexMiniTest

  def rack
    @rack ||= RackDispatcher.new(RackRequestStub)
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  def rack_call(method_name, args = {})
    env = { body:args.to_json, path_info:method_name }
    result,_stderr = with_captured_stderr { rack.call(env) }
    @json = JSON.parse(result[2][0])
  end

  def assert_exception(expected)
    assert_equal jpg(expected), jpg(@json['exception']), jpg(@json)
  end

  def jpg(o)
    JSON.pretty_generate(o)
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  def sha
    rack_call(__method__.to_s, {})
    @json[__method__.to_s]
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  def language_start_points
    rack_call(__method__.to_s, {})
    @json[__method__.to_s]
  end

  def language_manifest(display_name, exercise_name)
    args = {
      display_name:display_name,
      exercise_name:exercise_name
    }
    rack_call(__method__.to_s, args)
    @json[__method__.to_s]
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  def custom_start_points
    rack_call(__method__.to_s, {})
    @json[__method__.to_s]
  end

  def custom_manifest(display_name)
    args = { display_name:display_name }
    rack_call(__method__.to_s, args)
    @json[__method__.to_s]
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  def assert_rack_call_raw(path_info, args, expected)
    rack = RackDispatcher.new(RackRequestStub)
    env = { body:args, path_info:path_info }
    tuple,_stderr = with_captured_stderr { rack.call(env) }
    assert_equal 200, tuple[0]
    assert_equal({ 'Content-Type' => 'application/json' }, tuple[1])
    assert_equal [ expected.to_json ], tuple[2]
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  def with_captured_stderr
    begin
      old_stderr = $stderr
      $stderr = StringIO.new('', 'w')
      tuple = yield
      return [ tuple, $stderr.string ]
    ensure
      $stderr = old_stderr
    end
  end

end
