require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe "JerryMice" do

  it "should copy config files" do
    FileUtils.stub!(:cp).with('/Users/lung/sandbox/gems/JerryMice/lib/../config/jerrymice.rb', '/Users/lung/sandbox/gems/JerryMice/config/')
    FileUtils.stub!(:cp).with('/Users/lung/sandbox/gems/JerryMice/lib/../set_env', '/Users/lung/sandbox/gems/JerryMice')
    JerryMice.copy
  end
  
  it "should require rake tasks" do
    application = mock('rake application')
    application.should_receive(:rake_require).with('../tasks/deploy')
    application.should_receive(:rake_require).with('../tasks/gems')
    application.should_receive(:rake_require).with('../tasks/gitignore')
    application.should_receive(:rake_require).with('../tasks/war')
    Rake.stub!(:application).and_return(application)
    JerryMice.require_tasks
  end

end
