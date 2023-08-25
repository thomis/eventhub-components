require "socket"
# A wrapper for loggers to enrich the log message with structured data (a Hash).
# All methods besides debug/info/warn/error/fatal are forwarded to the target by the means of method_missing.
class EventHub::Components::StructuredDataLogger
  SEVERITY_DEBUG = 7
  SEVERITY_INFO = 6
  SEVERITY_WARNING = 4
  SEVERITY_ERROR = 3
  SEVERITY_FATAL = 0

  attr_reader :target, :options
  # Create a new Logger
  # target: an onject which behaves like a ruby logger.
  # options (keys are Strings):
  # * app_name: String, mandatory
  # * env: String, mandatory
  # * pid: Number, optional, defaults to Process.pid
  # * hostname, String, optional, defaults to Socket.gethostname
  # additional keys are possible and will be sent along. The keys :data and :message are reserved and must not be used.
  #
  def initialize(target, options)
    @target = target
    @options = options
    @options["pid"] ||= ::Process.pid
    @options["hostname"] ||= ::Socket.gethostname
    verify_options!
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

  def method_missing(...)
    target.send(...)
  end

  def respond_to_missing?(method)
    true
  end

  def build_message(severity, message, structured_data)
    options.merge({
      "severity" => severity,
      "data" => structured_data,
      "message" => message
    })
  end

  def verify_options!
    raise ::ArgumentError.new("target must not be nil") if target.nil?
    raise ::ArgumentError.new("data is a reserved key") if options.has_key?("data")
    raise ::ArgumentError.new("message is a reserved key") if options.has_key?("message")
    raise ::ArgumentError.new("app_name is required") if !options["app_name"]
    raise ::ArgumentError.new("env is required") if !options["env"]
  end
end
