module MyModule
  def module_method
    puts "I'm from MyModule."
  end
end

class MySuperclass
  include MyModule
end

class MySubclass1 < MySuperclass
  
end

obj_1 = MySubclass1.new
obj_1.module_method
