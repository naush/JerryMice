require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe "war task" do

  it "should run warble to create a config and pack a war file" do
    Kernel.stub!(:system).with('localgems/bin/warble config')
    Kernel.stub!(:system).with('localgems/bin/warble')
    War.execute
  end

end
