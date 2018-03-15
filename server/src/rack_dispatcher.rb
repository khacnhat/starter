require_relative 'starter'
require 'json'

class RackDispatcher

  def initialize(request)
    @request = request
    @starter = Starter.new
  end

  def call(env)
    request = @request.new(env)
    name, args = validated_name_args(request)
    triple({ name => @starter.public_send(name, *args) })
  rescue => error
    #puts "<#{error.message}>"
    #puts error.backtrace
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
      when /^language_start_points$/ then []
      when /^custom_start_points$/   then []
      when /^language_manifest$/     then [display_name,exercise_name]
      when /^custom_manifest$/       then [display_name]
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
    argument(__method__.to_s)
  end

  def exercise_name
    argument(__method__.to_s)
  end

  # - - - - - - - - - - - - - - - -
  # validations
  # - - - - - - - - - - - - - - - -

  def argument(name)
    unless @json_args.key?(name)
      raise ArgumentError.new("#{name}:missing")
    end
    @json_args[name]
  end

end
