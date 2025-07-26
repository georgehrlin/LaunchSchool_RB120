class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

# Q: How do we create two different instances of this class with separate names
# and ages?

angry_cat_1 = AngryCat.new(5, 'Red Hot')
angry_cat_2 = AngryCat.new(2, 'Chilly Pepper')
