class EventHub::Components::MultiLogger

  attr_accessor :devices

  def initialize(folder=nil)
    @devices = []
  end

  def add_device(device)
    raise ::ArgumentError.new("can not add nil device") if device.nil?
    @devices << device
    self
  end


  private

  def method_missing(method, *args, &block)
    devices.map do |target|
      begin
        target.send(method, *args, &block)
      rescue => e
        ::STDERR.puts "WARNING: Could not call #{method} in #{target} with #{args} because of #{e.message}"
        e
      end
    end
  end
end
