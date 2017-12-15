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

=begin
  def assert_no_exception
    assert_exception(nil)
  end

  def assert_exception(expected)
    assert_equal jpg(expected), jpg(@json['exception']), jpg(@json)
  end

  def jpg(o)
    JSON.pretty_generate(o)
  end
=end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  def languages_choices(kata_id)
    args = { kata_id:kata_id }
    rack_call(__method__.to_s, args)
    @json[__method__.to_s]
  end

end
