class EventHub::Components::ExceptionWriter

  MAX_EXCEPTIONS_FILES = 500

  attr_accessor :folder, :max_files

  def initialize(base = nil, max_files = MAX_EXCEPTIONS_FILES)
    base = base ||= Dir.pwd
    @folder = File.join(base, 'exceptions')
    @max_files = max_files
  end


  def write(exception, message = nil)
    time = Time.now
    stamp = "#{time.strftime("%Y%m%d_%H%M%S")}_%i" % time.usec

    # create exception folder when it's needed (but not before)
    FileUtils.makedirs(@folder)

    write_exception("#{stamp}.log", exception)
    write_message("#{stamp}.msg.raw", message)

    restrict_to_max_files

    stamp
  end


  private

  def restrict_to_max_files
    exception_files = Dir.glob(File.join(folder, '*.log'))
    if exception_files.size > max_files
      exception_files.reverse[max_files..-1].each do |file|
        begin
          File.delete(file)
          raw = File.join(File.dirname(file), File.basename(file, ".*"), '.msg.raw')
          File.delete(raw)
        rescue
        end
      end
    end
  end

  def write_exception(filename, exception)
    File.open("#{folder}/#{filename}", "w") do |output|
      output.write("#{exception}\n\n")
      output.write("Exception: #{exception.class.to_s}\n\n")
      output.write("Call Stack:\n")
      exception.backtrace.each do |line|
        output.write("#{line}\n")
      end if exception.backtrace
    end
  end

  def write_message(filename, message)
    return unless message
    File.open("#{folder}/#{filename}","wb") do |output|
      output.write(message)
    end
  end

end
