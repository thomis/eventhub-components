require_relative "../spec_helper"

RSpec.describe EventHub::Components::StructuredDataLogger do
  let!(:logger) { EventHub::Components::LogFormatter.new }
  it "formats logs" do
    expect(logger.call("ERROR", Time.now, "rspec", "just a message")).to match(/^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}.\d+\t\d+\tERROR\tjust a message\n$/)
  end
end
