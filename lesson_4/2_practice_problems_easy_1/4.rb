=begin
If we have a class AngryCat how do we create a new instance of this class?

The AngryCat class might look something like this:
=end

class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

# Answer
angry_cat_1 = AngryCat.new
angry_cat_1.hiss # >> Hisssss!!!
