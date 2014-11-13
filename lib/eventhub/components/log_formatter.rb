# format adaptation
class EventHub::Components::LogFormatter
  def call(severity, time, progname, msg)
    time_in_string = "#{time.strftime("%Y-%m-%d %H:%M:%S")}.#{"%04d" % (time.usec/100)}"
    [time_in_string, Process.pid, severity,msg].join("\t") + "\n"
  end
end
