module MyModule
  @@a_class_var = 'xdd'

    def self.show_cvar
      @@a_class_var
    end

    def show_cvar
      @@a_class_var
    end
end

class MyClass
  include MyModule
end

# p MyClass.show_cvar

p MyClass.new.show_cvar