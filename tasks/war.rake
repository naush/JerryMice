require File.join(File.dirname(__FILE__), '../lib/war')

namespace :jerry do
  desc "Run warble script"
  task :war do
    War.execute
  end
end
