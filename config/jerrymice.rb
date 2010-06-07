module JerryMice
  def self.required_gems
    {
      "warbler" => "1.1.0",
      "gemcutter" => "0.5.0",
      "json_pure" => "1.1.3",
      "rubyforge" => "0.4.0",
      "open4" => "0.9.3",
      "rake" => "0.8.7",
      "net-scp" => "1.0.2",
      "net-ssh" => "2.0.22",
      "jruby-jars" => "1.5.0",
      "jruby-rack" => "0.9.8",
      "jruby-openssl" => "0.7",
      "rubyzip" => "0.9.4"
    }
  end
  def self.config
    {
      "hostname" => "your hostname",
      "username" => "your username",
      "password" => "your password",
      "localpath" => "/path/to/project.war",
      "remotepath" => "/path/to/tomcat/webapps/"
    }
  end
end
