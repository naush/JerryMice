module War
  def self.execute
    Kernel.system "localgems/bin/warble config"
    Kernel.system "localgems/bin/warble"
  end
end
