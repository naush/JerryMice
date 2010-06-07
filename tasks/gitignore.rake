require File.join(File.dirname(__FILE__), '../lib/gitignore')

namespace :jerry do
  desc "Create .gitignore file"
  task :gitignore do
    GitIgnore.execute
  end
end
