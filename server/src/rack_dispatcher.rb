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
    result = @starter.public_send(name, *args)
    json_response({ name => result })
  rescue => error
    #puts "<#{error.message}>"
    #puts error.backtrace
    json_response({ 'exception' => error.message })
  end

  private # = = = = = = = = = = = =

  def validated_name_args(request)
    name = request.path_info[1..-1] # lose leading /
    @args = json_parse(request.body.read)
    unless @args.is_a?(Hash)
      raise 'json:!Hash'
    end
    args = case name
      when /^sha$/                   then []
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

  def json_response(body)
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
    unless @args.key?(name)
      raise ArgumentError.new("#{name}:missing")
    end
    @args[name]
  end

end
