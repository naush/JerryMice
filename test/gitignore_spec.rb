require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe "gitignore task" do

  before (:each) do
    @file = mock('file')
  end

  it "should create a file named .gitignore" do
    File.stub!(:open).with(".gitignore", "w").and_return(@file)
    File.stub!(:close).with(".gitignore").and_return(true)
    GitIgnore.execute
  end

  it "should write ignored directories to .gitignore" do
    @file.stub!(:write).with("localgems/cache/\nlocalgems/specification/\nlocalgems/bin/\nlocalgems/documentation/\nlocalgems/gems/")
    File.stub!(:open).with(".gitignore", "w").and_return(@file)
    File.stub!(:close).with(".gitignore").and_return(true)
    GitIgnore.execute
  end

end
