require_relative '../spec_helper'

RSpec.describe EventHub::Components::StructuredDataLogger do
  context 'logger' do

    let(:logger) {
      EventHub::Components::MultiLogger.new
    }


    it 'forwards calls to ALL devices' do
      device_1 = stub(:device_1)
      expect(device_1).to receive(:info).and_return(1)
      device_2 = stub(:device_2)
      expect(device_2).to receive(:info).and_return(2)

      logger.add_device(device_1)
      logger.add_device(device_2)

      result = logger.info("hans")
      expect(result).to eq([1, 2])
    end
  end
end
