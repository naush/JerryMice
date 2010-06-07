require 'rubygems'
require 'spec'

ENV['GEM_PATH'] ||= File.expand_path(File.dirname(__FILE__) + "/localgems")
Gem.clear_paths
ENV['GEM_HOME'] ||= File.expand_path(File.dirname(__FILE__) + "/localgems")

Dir[File.expand_path(File.join(File.dirname(__FILE__), 'lib', '*.rb'))].each { |f| require f }
