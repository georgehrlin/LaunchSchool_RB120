class OperatingSystem
  def initialize(name, version)
    @name = name
    @version = version
  end

  def display_os_detail
    puts "#{@name} #{version}"
  end

  private

  attr_reader :name, :version
end

os1 = OperatingSystem.new('MacOS', 'Sequoia')
os1.display_os_detail
