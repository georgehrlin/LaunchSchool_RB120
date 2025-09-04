module Namespace1
  module MyModule
    def do_something
      puts "I'm: #{self}!"
    end
  end

  class MyClass1
    include MyModule
  end

  class MyClass2
    include MyModule
  end
end

Namespace1::MyClass1.new.do_something
Namespace1::MyClass2.new.do_something