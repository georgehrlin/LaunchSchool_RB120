class PersonalComputer
  HIIMACONSTANT = 99
  @@total_num_machines = 0

  def initialize
    @@total_num_machines += 1
  end

  def self.total_num_machines
    @@total_num_machines
  end

  def self.mess_with_constant(n)
    HIIMACONSTANT = HIIMACONSTANT + 1
    puts HIIMACONSTANT
  end
end

class Macintosh < PersonalComputer; end

class MicrosoftPC < PersonalComputer; end

mac1 = Macintosh.new
pc1 = MicrosoftPC.new

# p PersonalComputer.total_num_machines # => 2
PersonalComputer.mess_with_constant
