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
      when /^custom_choices$/    then []
      when /^languages_choices$/ then []
      when /^exercises_choices$/ then []
      when /^custom_manifest$/   then [major_name,minor_name]
      when /^language_manifest$/ then [major_name,minor_name,exercise_name]
      when /^manifest$/          then [old_name]
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

  def major_name
    validated_string(__method__.to_s)
  end

  def minor_name
    validated_string(__method__.to_s)
  end

  def exercise_name
    validated_string(__method__.to_s)
  end

  def old_name
    validated_string(__method__.to_s)
  end

  # - - - - - - - - - - - - - - - -
  # validations
  # - - - - - - - - - - - - - - - -

  def validated_string(name)
    arg = argument(name)
    unless arg.is_a?(String)
      raise invalid(name)
    end
    arg
  end

  def argument(name)
    unless @json_args.key?(name)
      raise error(name, 'missing')
    end
    @json_args[name]
  end

  def invalid(name)
    error(name, 'invalid')
  end

  def error(name, message)
    ArgumentError.new("#{name}:#{message}")
  end

end
