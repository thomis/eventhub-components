require_relative "../spec_helper"

RSpec.describe EventHub::Components::StructuredDataLogger do
  context "initalize" do
    it "no raise when all required arguments are given" do
      expect {
        EventHub::Components::StructuredDataLogger.new("something not nil", "app_name" => "an app", "env" => "test")
      }.to_not raise_error
    end
    it "requires app_name" do
      expect {
        EventHub::Components::StructuredDataLogger.new("something not nil", "env" => "test")
      }.to raise_error(ArgumentError)
    end
    it "requires app_name" do
      expect {
        EventHub::Components::StructuredDataLogger.new("something not nil", "app_name" => "an app")
      }.to raise_error(ArgumentError)
    end

    it "adds the default options" do
      logger = EventHub::Components::StructuredDataLogger.new("something not nil", "app_name" => "an app", "env" => "test")
      expect(logger.options["pid"]).to eq(::Process.pid)
      expect(logger.options["hostname"]).to eq(::Socket.gethostname)
    end
  end

  context "proxy" do
    let(:logger) do
      # fake logger that stores a log message
      # in hash
      fake_logger = {}
      def fake_logger.debug(message)
        self[:debug] = message
      end

      def fake_logger.info(message)
        self[:info] = message
      end

      def fake_logger.warn(message)
        self[:warn] = message
      end

      def fake_logger.error(message)
        self[:error] = message
      end

      def fake_logger.fatal(message)
        self[:fatal] = message
      end

      fake_logger
    end
    subject {
      EventHub::Components::StructuredDataLogger.new(logger, "app_name" => "an app", "env" => "test")
    }

    it "enriches and forwards debug calls" do
      subject.debug("my message debug", {"some" => "debug"})
      expectation = {"app_name" => "an app", "data" => {"some" => "debug"}, "env" => "test", "hostname" => Socket.gethostname, "message" => "my message debug", "pid" => Process.pid, "severity" => 7}
      expect(logger[:debug]).to eq(expectation)
    end

    it "enriches and forwards info calls" do
      subject.info("my message info", {"some" => "info"})
      expectation = {"app_name" => "an app", "data" => {"some" => "info"}, "env" => "test", "hostname" => Socket.gethostname, "message" => "my message info", "pid" => Process.pid, "severity" => 6}
      expect(logger[:info]).to eq(expectation)
    end

    it "enriches and forwards warn calls" do
      subject.warn("my message warn", {"some" => "warn"})
      expectation = {"app_name" => "an app", "data" => {"some" => "warn"}, "env" => "test", "hostname" => Socket.gethostname, "message" => "my message warn", "pid" => Process.pid, "severity" => 4}
      expect(logger[:warn]).to eq(expectation)
    end

    it "enriches and forwards error calls" do
      subject.error("my message error", {"some" => "error"})
      expectation = {"app_name" => "an app", "data" => {"some" => "error"}, "env" => "test", "hostname" => Socket.gethostname, "message" => "my message error", "pid" => Process.pid, "severity" => 3}
      expect(logger[:error]).to eq(expectation)
    end

    it "enriches and forwards fatal calls" do
      subject.fatal("my message fatal", {"some" => "fatal"})
      expectation = {"app_name" => "an app", "data" => {"some" => "fatal"}, "env" => "test", "hostname" => Socket.gethostname, "message" => "my message fatal", "pid" => Process.pid, "severity" => 0}
      expect(logger[:fatal]).to eq(expectation)
    end
  end

  context "unknown methods" do
    let(:logger) { EventHub::Components::StructuredDataLogger.new("something not nil", "app_name" => "an app", "env" => "test") }
    it "response to an unknown method" do
      expect(logger.respond_to?(:whatever)).to eq(true)
    end

    it "can call an unknown method" do
      expect { logger.size }.not_to raise_error
    end
  end
end
