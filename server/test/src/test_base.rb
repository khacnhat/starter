require_relative 'hex_mini_test'
require_relative 'rack_request_stub'
require_relative '../../src/rack_dispatcher'
require 'json'

class TestBase < HexMiniTest

  def rack
    @rack ||= RackDispatcher.new(RackRequestStub)
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  def rack_call(method_name, args = {})
    env = { body:args.to_json, path_info:method_name }
    result = rack.call(env)
    @json = JSON.parse(result[2][0])
  end

  def assert_exception(expected)
    assert_equal jpg(expected), jpg(@json['exception']), jpg(@json)
  end

  def jpg(o)
    JSON.pretty_generate(o)
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  def languages_choices(current_display_name)
    args = { current_display_name:current_display_name }
    rack_call(__method__.to_s, args)
    @json[__method__.to_s]
  end

  def exercises_choices(current_exercise_name)
    args = { current_exercise_name:current_exercise_name }
    rack_call(__method__.to_s, args)
    @json[__method__.to_s]
  end

end
