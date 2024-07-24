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

  def self.logstash_cloud(processor_name, environment)
    # configure logstash with custom fields
    LogStashLogger.configure do |config|
      config.customize_event do |event|
        # renaming default fields to be eventhub cloud compatible
        event["time"] = event.remove("@timestamp")
        event["msg"] = event.remove("message")
        event["level"] = event.remove("severity")
        event["host"] = event.remove("host") # reordering
        event.remove("@version") # not needed

        # additional fields
        event["app"] = processor_name
        event["env"] = environment
      end
    end
    LogStashLogger.new([{type: :stdout}])
  end
end
