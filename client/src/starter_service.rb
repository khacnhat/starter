require_relative 'http_json_service'

class StarterService

  def language_start_points
    get([], __method__)
  end

  def language_manifest(display_name, exercise_name)
    get([display_name,exercise_name], __method__)
  end

  # - - - - - - - - - - - - - - - - - - - - -

  def custom_start_points
    get([], __method__)
  end

  def custom_manifest(display_name)
    get([display_name], __method__)
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
