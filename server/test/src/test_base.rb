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
    env = { body:args.to_json, path_info:method_name.to_s }
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

  def method(a,b)
    args = { a:a, b:b }
    rack_call('method', args)
    @json['method']
  end

end
