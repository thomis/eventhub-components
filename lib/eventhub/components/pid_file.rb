class EventHub::Components::Pidfile
  attr_reader :file_name
  def initialize(file_name)
    @file_name = file_name
  end

  # write the pid to the file specified in the initializer
  # defaults to Process.pid
  def write(pid = Process.pid)
    FileUtils.makedirs(File.dirname(file_name))
    IO.write(file_name, pid.to_s)
  end

  # Try to delete file, ignore all errors
  def delete
    File.delete(file_name)
  rescue
    # ignore
  end

  # Read the PID from the file
  def read
    File.read(file_name)
  rescue Errno::ENOENT
    # ignore, will return nil
  end
end
