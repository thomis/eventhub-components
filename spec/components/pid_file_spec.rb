require 'spec_helper'
require 'fileutils'

describe EventHub::Components::Pidfile do
  before(:each) do
    FileUtils.remove_dir('/tmp/eventhub_pid_test', true)
  end

  after(:each) do
    FileUtils.remove_dir('/tmp/eventhub_pid_test', true)
  end

  let(:pidfile) {  pidfile = EventHub::Components::Pidfile.new('/tmp/eventhub_pid_test/some.pid') }

  it 'creates the folders if not existing' do
    pidfile.write(1234)
    expect(File.directory?('/tmp/eventhub_pid_test')).to be true
  end

  it 'writes the content to the file' do
    pidfile.write(1234)
    expect(IO.read('/tmp/eventhub_pid_test/some.pid')).to eq('1234')
  end

  it 'deletes the file' do
    pidfile.write(1234)
    pidfile.delete
    expect(File.file?('/tmp/eventhub_pid_test/some.pid')).to be false
  end

  it 'does not choke when deleting a non-existing pid file' do
    pidfile.delete
  end

  it 'does not choke when reading a non-existing pid file' do
    expect(pidfile.read).to eq(nil)
  end

  it 'reads the pid written to the file' do
    pidfile.write(1234)
    expect(pidfile.read).to eq("1234")
  end

  it 'it writes the currents process pid as default' do
    pidfile.write
    expect(pidfile.read).to eq(Process.pid.to_s)
  end
end
