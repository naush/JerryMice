require File.join(File.dirname(__FILE__), '../lib/gems')

namespace :jerry do
  desc "Install gems in local directory"
  task :gems do
    Gems.execute
  end
end
