class EventHub::Components::Logger
  def self.stdout
    logger = Logger.new($stdout)
    logger.formatter = proc do |severity, time, progname, msg|
      time_in_string = "#{time.strftime("%Y-%m-%d %H:%M:%S")}.#{"%04d" % (time.usec / 100)}"
      "#{time_in_string}: #{"%10s" % severity} - #{msg}\n"
    end
    logger
  end

  def self.logstash(processor_name, environment)
    # configure logstash with custom fields
    LogStashLogger.configure do |config|
      config.customize_event do |event|
        event["app_name"] = processor_name
        event["env"] = environment
      end
    end
    LogStashLogger.new([{type: :file, path: "logs/ruby/#{processor_name}.log", sync: true}])
  end
end
