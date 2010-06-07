require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('jerrymice', '0.1.0') do |p|
  p.description     = "Deploy your rails app on a Tomcat server"
  p.url             = "http://github.com/naush/jerrymouse"
  p.author          = "Li-Hsuan Lung"
  p.email           = "lihsuan@8thlight.com"
  p.ignore_pattern  = ["tmp/*", "script/*"]
  p.development_dependencies = ["warbler", "net-ssh", "net-scp"]
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
