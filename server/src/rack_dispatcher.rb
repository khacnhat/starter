require_relative 'starter'
require 'json'

class RackDispatcher

  def initialize(request = Rack::Request)
    @request = request
  end

  def call(env)
    request = @request.new(env)
    name, args = validated_name_args(request)
    starter = Starter.new
    result = starter.public_send(name, *args)
    body = { name => result }
    triple(body)
  rescue => error
    triple({ 'exception' => error.message })
  end

  private # = = = = = = = = = = = =

  def validated_name_args(request)
    name = request.path_info[1..-1] # lose leading /
    @json_args = json_parse(request.body.read)
    unless @json_args.is_a?(Hash)
      raise 'json:!Hash'
    end
    args = case name
      when /^languages_choices$/ then [display_name]
    end
    [name, args]
  end

  def json_parse(request)
    JSON.parse(request)
  rescue
    raise 'json:invalid'
  end

  def triple(body)
    [ 200, { 'Content-Type' => 'application/json' }, [ body.to_json ] ]
  end

  # - - - - - - - - - - - - - - - -
  # method arguments
  # - - - - - - - - - - - - - - - -

  def display_name
    validated_display_name
  end

  # - - - - - - - - - - - - - - - -
  # validations
  # - - - - - - - - - - - - - - - -

  def validated_display_name
    arg = @json_args['display_name']
    unless arg.is_a?(String) || arg.is_a?(NilClass)
      raise invalid('display_name')
    end
    arg
  end

  # - - - - - - - - - - - - - - - -

  def invalid(name)
    ArgumentError.new("#{name}:invalid")
  end

end
