class EventHub::Components::MultiLogger < BasicObject

  attr_accessor :devices

  def initialize(folder=nil)
      @devices = []
  end

  def add_device(device)
    @devices << device
  end


  private

  def method_missing(method, *args, &block)
    devices.map do |target|
      target.send(method, *args, &block)
    end
  end
end
