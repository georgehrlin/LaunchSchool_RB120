class Bird
  def fly
    p "#{self.class} is flying!"
  end
end

class Pigeon < Bird; end
class Duck < Bird; end

birds = [Bird.new, Pigeon.new, Duck.new].each(&:fly)

=begin
A: This code demonstrates polymorphism via class inheritance. It outputs:
Bird is flying!
Pigeon is flying!
Duck is flying!
=end

=begin
Correction: I mistook the p on line 3 as puts. The correct output is:
"Bird is flying!"
"Pigeon is flying!"
"Duck is flying!"
=end
