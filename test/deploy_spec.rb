require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'config/jerrymice'
require 'net/ssh'
require 'net/scp'

describe "deploy task" do

  it "should deploy" do
    config = mock("array of configurations")
    config.should_receive(:[]).with('hostname').and_return('hostname')
    config.should_receive(:[]).with('username').and_return('username')
    config.should_receive(:[]).with('password').and_return('password')
    # config.should_receive(:[]).with('localpath').and_return('localpath')
    # config.should_receive(:[]).with('remotepath').and_return('remotepath')
    JerryMice.stub!(:config).and_return(config)
    scp = mock('scp')
    # scp.should_receive(:upload!).with('localpath', 'remotepath')
    Net::SCP.stub!(:start).with('hostname', 'username', {:password => 'password'}).and_return(scp)
    Deploy.execute
  end

end
