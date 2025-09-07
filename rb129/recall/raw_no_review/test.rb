class Wallet
  include Comparable

  attr_reader :balance

  def initialize(balance)
    @balance = balance
  end

  def <=>(other)
    if balance < other.balance
      -1
    elsif balance > other.balance
      1
    elsif balance == other.balance
      0
    end
  end
end

wallet1 = Wallet.new(100)
wallet2 = Wallet.new(50)

p wallet1 > wallet2 # => true
p wallet1 < wallet2 # => false