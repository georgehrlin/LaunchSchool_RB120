module Conversions
  def self.farenheit_to_celsius(num)
    (num - 32) * 5 / 9
  end
end

value = Conversions.farenheit_to_celsius(32)  # Preferred way
value = Conversions::farenheit_to_celsius(32) # Works, but not preferred
