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
      when /^languages_choices$/ then [current_display_name]
      when /^custom_choices$/    then [current_display_name]
      when /^exercises_choices$/ then [current_exercise_name]
      when /^language_manifest$/ then [major_name,minor_name,exercise_name]
      when /^custom_manifest$/ then [major_name,minor_name]
      #when /^manifest$/ then [display_name]
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

  def current_display_name
    validated_current_display_name(arg('current_display_name'))
  end

  def current_exercise_name
    validated_current_exercise_name(arg('current_exercise_name'))
  end

  def major_name
    validated_major_name(arg('major_name'))
  end

  def minor_name
    validated_minor_name(arg('minor_name'))
  end

  def exercise_name
    validated_exercise_name(arg('exercise_name'))
  end

  # - - - - - - - - - - - - - - - -
  # validations
  # - - - - - - - - - - - - - - - -

  def validated_current_display_name(arg)
    unless arg.is_a?(String) || arg.is_a?(NilClass)
      raise invalid('current_display_name')
    end
    arg
  end

  def validated_current_exercise_name(arg)
    unless arg.is_a?(String) || arg.is_a?(NilClass)
      raise invalid('current_exercise_name')
    end
    arg
  end

  def validated_major_name(arg)
    unless arg.is_a?(String)
      raise invalid('major_name')
    end
    arg
  end

  def validated_minor_name(arg)
    unless arg.is_a?(String)
      raise invalid('minor_name')
    end
    arg
  end

  def validated_exercise_name(arg)
    unless arg.is_a?(String)
      raise invalid('exercise_name')
    end
    arg
  end

  # - - - - - - - - - - - - - - - -

  def arg(name)
    unless @json_args.key?(name)
      raise error(name, 'missing')
    end
    @json_args[name]
  end

  # - - - - - - - - - - - - - - - -

  def invalid(name)
    error(name, 'invalid')
  end

  def error(name, message)
    ArgumentError.new("#{name}:#{message}")
  end

end
