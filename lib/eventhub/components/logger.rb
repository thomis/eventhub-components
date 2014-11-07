require 'socket'
require 'thread'
class Eventhub::Components::Logger < BasicObject
  SEVERITY_DEBUG = 7
  SEVERITY_INFO = 6
  SEVERITY_WARNING = 4
  SEVERITY_ERROR = 3
  SEVERITY_FATAL = 0

  attr_reader :target, :app_name, :pid, :hostname, :env

  def initialize(target, app_name, env)
    @target = target
    @app_name = app_name
    @pid = ::Process.pid
    @hostname = ::Socket.gethostname
    @env = env
  end

  def debug(message, structured_data = nil)
    target.debug(build_message(SEVERITY_DEBUG, message, structured_data))
  end

  def info(message, structured_data = nil)
    target.info(build_message(SEVERITY_INFO, message, structured_data))
  end

  def warn(message, structured_data = nil)
    target.warn(build_message(SEVERITY_WARNING, message, structured_data))
  end

  def error(message, structured_data = nil)
    target.error(build_message(SEVERITY_ERROR, message, structured_data))
  end

  # fatal <=> emergeny <=> alert
  def fatal(message, structured_data = nil)
    target.fatal(build_message(SEVERITY_FATAL, message, structured_data))
  end

  private

  def method_missing(method, *args, &block)
    target.send(method, *args, &block)
  end

  def build_message(severity, message, structured_data)
    {
      'severity' => severity,
      'data' => structured_data,
      'pid' => pid,
      'host' => hostname,
      'message' => message,
      'env' => env
    }
  end

end
