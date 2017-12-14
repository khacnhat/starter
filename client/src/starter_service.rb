require_relative 'http_json_service'

class StarterService

  def method(a,b)
    args = [a,b]
    get(args, __method__)
  end

  private

  include HttpJsonService

  def hostname
    ENV['CYBER_DOJO_STARTER_SERVER_NAME']
  end

  def port
    ENV['CYBER_DOJO_STARTER_SERVER_PORT']
  end

end
