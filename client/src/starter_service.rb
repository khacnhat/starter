require_relative 'http_json_service'

class StarterService

  def custom_choices
    get([], __method__)
  end

  def languages_choices
    get([], __method__)
  end

  def exercises_choices
    get([], __method__)
  end

  # - - - - - - - - - - - - - - - - - - - - -

  def custom_manifest(major_name, minor_name)
    get([major_name,minor_name], __method__)
  end

  def language_manifest(major_name, minor_name, exercise_name)
    get([major_name,minor_name,exercise_name], __method__)
  end

  def manifest(old_name)
    get([old_name], __method__)
  end

  private

  include HttpJsonService

  def hostname
    ENV['CYBER_DOJO_STARTER_SERVICE_NAME']
  end

  def port
    ENV['CYBER_DOJO_STARTER_SERVICE_PORT']
  end

end
