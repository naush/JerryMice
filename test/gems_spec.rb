require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'config/jerrymice'

describe "gems task" do

  it "should make localgems directory" do
    File.stub!(:exists).with('localgems').and_return(false)
    File.stub!(:exists).with('localgems/required_gems').and_return(false)
    Kernel.stub!(:mkdir).with('localgems')
    Kernel.stub!(:mkdir).with('localgems/required_gems')
    Gems.make_dir
  end

  it "should find all installed gems" do
    installed_gems = ['warbler-1.1.0.gem', 'rake-0.8.7.gem']
    Dir.stub!(:entries).with('localgems/gems').and_return(installed_gems)
    Gems.find_installed_gems.should == installed_gems
  end

  it "should find all required gems" do
    required_gems = {'warbler' => '1.1.0', 'rake' => '0.8.7'}
    JerryMice.stub!(:required_gems).and_return(required_gems)
    Gems.find_required_gems.should == ['rake-0.8.7', 'warbler-1.1.0']
  end

  it "should fetch gems" do
    gems_to_fetch = ['rake-0.8.7', 'warbler-1.1.0', 'jruby-openssl-0.7']
    Kernel.stub!(:system).with('gem fetch rake --version=0.8.7')
    Kernel.stub!(:system).with('gem fetch warbler --version=1.1.0')
    Kernel.stub!(:system).with('gem fetch jruby-openssl --version=0.7')
    Gems.fetch_gems(gems_to_fetch)
  end

  it "should move gems to localgems/required_gems" do
    entries = ['rake-0.8.7.gem', 'warbler-1.1.0.gem']
    Dir.stub!(:entries).with('.').and_return(entries)
    Kernel.stub!(:system).with('mv rake-0.8.7.gem localgems/required_gems')
    Kernel.stub!(:system).with('mv warbler-1.1.0.gem localgems/required_gems')
    Gems.move_gems
  end

  it "should add gems to intall" do
    entries = ['rake-0.8.7.gem', 'warbler-1.1.0.gem']
    Dir.stub!(:entries).with('localgems/required_gems').and_return(entries)
    Gems.add_gems("localgems").should == ['rake-0.8.7', 'warbler-1.1.0']
  end

  it "should install gems" do
    entries = ['rake-0.8.7.gem', 'warbler-1.1.0.gem']
    gems_to_install = mock('gems to install')
    gems_to_install.should_receive(:each).and_return(entries)
    Kernel.stub!(:system).with("gem install -i localgems --no-rdoc --no-ri -f -l localgems/required_gems/rake-0.8.7.gem")
    Kernel.stub!(:system).with("gem install -i localgems --no-rdoc --no-ri -f -l localgems/required_gems/warbler-1.1.0.gem")
    Gems.install_gems(gems_to_install)
  end

end
