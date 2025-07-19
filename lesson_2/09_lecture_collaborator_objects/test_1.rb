class PersonalComputer
  def initialize(brand, model)
    @brand = brand
    @model = model
  end

  def model
    @model
  end

  def model=(model)
    @model = model
    "My model is #{@model}!"
  end
end

mac1 = PersonalComputer.new('APPLE', 'MacBook Air M1 2020')
puts mac1.model
# >> MacBook Air M1 2020
puts mac1.model = "MacBook Pro M4 2024"
# >> MacBook Pro M4 2024
# NOT: My model is MacBook Pro M4 2024!

p a_local_var