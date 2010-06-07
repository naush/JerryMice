require 'rake'
require 'fileutils'

module JerryMice

  def self.load
	  copy
	  require_tasks
  end

  def self.copy
	  FileUtils.cp(File.join(File.dirname(__FILE__), '../config/jerrymice.rb'), Dir.pwd + '/config/')
    FileUtils.cp(File.join(File.dirname(__FILE__), '../set_env'), Dir.pwd)
	end
	
	def self.require_tasks
    Rake.application.rake_require '../tasks/deploy'
    Rake.application.rake_require '../tasks/gems'
    Rake.application.rake_require '../tasks/gitignore'
    Rake.application.rake_require '../tasks/war'
	end

end
