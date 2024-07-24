require_relative "../spec_helper"

RSpec.describe EventHub::Components::StructuredDataLogger do
  context "logger" do
    let(:logger) {
      EventHub::Components::MultiLogger.new
    }

    it "forwards calls to ALL devices" do
      device_1 = ""
      device_2 = ""

      allow(device_1).to receive(:info).and_return(1)
      allow(device_2).to receive(:info).and_return(2)

      logger.add_device(device_1)
      logger.add_device(device_2)

      result = logger.info("hans")
      expect(result).to eq([1, 2])
    end

    it "forwards calls to ALL devices even if one raises" do
      device_1 = ""
      device_2 = ""

      allow(device_1).to receive(:info).and_raise
      allow(device_2).to receive(:info).and_return(2)

      logger.add_device(device_1)
      logger.add_device(device_2)

      logger.info("hans")
    end

    it "returns self after adding device" do
      expect(logger.add_device("something")).to eq(logger)
    end

    it "does not allow nil as device" do
      expect {
        logger.add_device nil
      }.to raise_error(ArgumentError)
    end

    it "logs to json lines" do
      logger.add_device(EventHub::Components::Logger.logstash("processor", "development"))
      logger.info("Yes, it works!")
      expect(File.read("logs/ruby/processor.log")).to match(/Yes, it works!/)
    end

    it "logs to json lines and console" do
      logger.add_device(EventHub::Components::Logger.logstash("processor", "development"))
      logger.add_device(EventHub::Components::Logger.stdout)

      logger.info("Yes, it works2!")
      expect(File.read("logs/ruby/processor.log")).to match(/Yes, it works2!/)
    end

    it "response to an unknown method" do
      expect(logger.respond_to?(:whatever)).to eq(true)
    end

    it "logs json to standard output" do
      pattern = /\{"time":"\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{6}\+\d{2}:\d{2}","msg":"hello","level":"(INFO|WARN|ERROR|DEBUG|FATAL)","host":"[^\"]+","app":"processor","env":"development"\}/

      logger.add_device(EventHub::Components::Logger.logstash_cloud("processor", "development"))
      expect { logger.info("hello") }.to output(pattern).to_stdout_from_any_process
      expect { logger.warn("hello") }.to output(pattern).to_stdout_from_any_process
      expect { logger.error("hello") }.to output(pattern).to_stdout_from_any_process
      expect { logger.debug("hello") }.to output(pattern).to_stdout_from_any_process
      expect { logger.fatal("hello") }.to output(pattern).to_stdout_from_any_process
    end
  end
end
