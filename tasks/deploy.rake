require File.join(File.dirname(__FILE__), '../lib/deploy')

namespace :jerry do
  desc "Upload war to tomcat/webapps/"
  task :deploy => [:gitignore] do
    Deploy.execute
  end
end
