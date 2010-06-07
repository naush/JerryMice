require 'config/jerrymice'

module Gems

  GEM_PATTERN = /\W+\d+\.\d+(\.\d+)?(\-java)?\.gem/
  GEM_DIR_PATTERN = /\W+\d+\.\d+(\.\d+)?(\-java)?/
  GEM_DIR = 'localgems'
  GEM_REQUIRED_DIR = GEM_DIR + '/required_gems'

  def self.execute
    make_dir
    # clear_gems
    all_gems
  end

  def self.make_dir
    mkdir GEM_DIR if !File.exists?(GEM_DIR)
    mkdir GEM_REQUIRED_DIR if !File.exists?(GEM_REQUIRED_DIR)
  end

  def self.all_gems
    find_required_gems
    find_installed_gems
    gems_to_fetch = @required_gems - @installed_gems
    fetch_gems(gems_to_fetch)
    move_gems
    add_gems(sixty_four_bit?)
    install_gems(@gems_to_install, sixty_four_bit?)
  end

  def self.find_installed_gems
    @installed_gems = []
    Dir.entries("#{GEM_DIR}/gems").each { |entry| @installed_gems << entry if entry.match(GEM_DIR_PATTERN) } if File.exists?("#{GEM_DIR}/gems")
    return @installed_gems
  end

  def self.find_required_gems
    @required_gems = []
    JerryMice.required_gems.sort.each { |required_gem, version| @required_gems << required_gem + '-' + version }
    return @required_gems
  end

  def self.fetch_gems(gems_to_fetch)
    gems_to_fetch.each do |gem_to_fetch|
      puts "Fetching gem: #{gem_to_fetch}"
      gem_to_fetch = gem_to_fetch.split(/-/)
      Kernel.system "gem fetch #{gem_to_fetch[0...-1].join('-')} --version=#{gem_to_fetch[-1]}"
    end
  end

  def self.move_gems
    Dir.entries(".").each { |entry| Kernel.system "mv #{entry} #{GEM_REQUIRED_DIR}" if entry.match(GEM_PATTERN) }
  end

  def self.add_gems(use_sixty_four_bit=false)
    puts "Installing gems for 64-bit architecture (you are running Snow Leopard)" if use_sixty_four_bit
    @gems_to_install = []
    Dir.entries("#{GEM_DIR}/required_gems").each { |entry| @gems_to_install << entry[0...-4] if entry.match(GEM_PATTERN) }
    return @gems_to_install
  end

  def self.install_gems(gems_to_install, use_sixty_four_bit=false)
    arch_flags = use_sixty_four_bit ? sixty_four_bit_arch_flags : ""
    gems_to_install.each do |gem_to_install|
      puts "Installing gem: #{gem_to_install}"
      Kernel.system "#{arch_flags} gem install -i #{GEM_DIR} --no-rdoc --no-ri -f -l #{GEM_REQUIRED_DIR}/#{gem_to_install}.gem"
    end
  end

  # def self.clear_gems
  #   FileUtils.rm Dir.glob('localgems/bin/*')
  #   FileUtils.rm Dir.glob('localgems/cache/*')
  #   FileUtils.rm Dir.glob('localgems/specifications/*')
  #   FileUtils.rm Dir.glob('localgems/doc/*')
  #   FileUtils.rm Dir.glob("localgems/required_gems/*")
  #   FileUtils.rm_rf Dir.glob("localgems/gems/*")
  # end

  def self.sixty_four_bit?
    `uname -r`.include?("10.0.0") && `uname -s`.include?("Darwin")
  end

  def self.sixty_four_bit_arch_flags
    sixty_four_bit? ? "env ARCHFLAGS=\"-arch x86_64\"" : ""
  end

end
