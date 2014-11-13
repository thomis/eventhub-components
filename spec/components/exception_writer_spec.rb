require_relative '../spec_helper'

RSpec.describe EventHub::Components::StructuredDataLogger do
  context 'logger' do

    before(:each) do
      remove_all_exception_files
    end

    after(:each) do
      remove_all_exception_files
    end

    let(:writer) {
      EventHub::Components::ExceptionWriter.new('tmp', 5)
    }

    it 'writes an exception' do
      begin
        raise
      rescue => e
        name = writer.write(e)
      end
      expect(Dir['tmp/exceptions/*'].size).to eq(1)
    end

    it 'writes an exception and a message' do
      begin
        raise
      rescue => e
        name = writer.write(e, "hi")
      end
      expect(Dir['tmp/exceptions/*'].size).to eq(2)
    end

    it 'limits number of files' do
      begin
        raise
      rescue => e
        (writer.max_files + 1).times do
          writer.write(e)
        end
      end
      expect(Dir['tmp/exceptions/*'].size).to eq(5)
    end

  end

  def remove_all_exception_files
    Dir['tmp/exceptions/*'].each do |file|
      File.delete(file)
    end
  end
end
