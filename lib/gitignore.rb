module GitIgnore
  IGNORED_DIRECTORIES = "localgems/cache/\nlocalgems/specification/\nlocalgems/bin/\nlocalgems/documentation/\nlocalgems/gems/"
  def self.execute
    File.open('.gitignore', 'w') { |f| f.write(IGNORED_DIRECTORIES) }
  end
end
