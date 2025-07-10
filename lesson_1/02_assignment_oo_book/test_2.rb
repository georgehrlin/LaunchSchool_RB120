class MyCar
  attr_accessor :color
  attr_reader :year, :model

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
  end

  def to_s
    puts "My car is a(n) #{color} #{year} #{model}."
  end
end

silver_bullet = MyCar.new(1984, "silver", "Subaru")
puts silver_bullet
