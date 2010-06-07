require 'net/ssh'
require 'net/scp'
require 'config/jerrymice'

module Deploy
  def self.execute
    config = JerryMice.config
    Net::SCP.start(config['hostname'], config['username'], :password => config['password']) do |scp|
      scp.upload!(config['localpath'], config['remotepath'])
    end
  end
end
