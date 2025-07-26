class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

=begin
A: Ben is right. Line 9 is not missing an @ to work properly. balance on line 9
references the reader method balance, which is defined and it accesses the
instance variable @balance, so balance >= 9 does work properly.
=end
