# Collaborator Objects
A collaborator object is an object that is part of another object's state.

```ruby
class PCDIY
  attr_reader :cpu, :gpu

  def initialize(cpu, gpu)
    @cpu = cpu
    @gpu = gpu
  end
end

class CPU
  def initialize(brand, model)
    @brand = brand
    @model = model
  end
end

class GPU
  def initialize(brand, model)
    @brand = brand
    @model = model
  end
end

cpu = CPU.new('AMD', '9950X3D')
p cpu # => #<CPU:0x0000000102c41b18 @brand="AMD", @model="9950X3D">
gpu = GPU.new('Asus', 'ROG Astral OC RTX 5090')
p gpu # => #<GPU:0x0000000102c41870 @brand="Asus", @model="ROG Astral OC RTX 5090">
pc = PCDIY.new(cpu, gpu)
p pc.cpu # => #<CPU:0x0000000102c41b18 @brand="AMD", @model="9950X3D">
p pc.gpu # => #<GPU:0x0000000102c41870 @brand="Asus", @model="ROG Astral OC RTX 5090">
# cpu and gpu are collaborator objects of pc
```

The code above illustrates (?), which refers to a kind of relationship between a container object and its collaborator object(s). In (?), the life span of the collaborator object(s) is not tied up with the container object.

Another relationship is composition, where a collaborator object is instantiated by the constructor of the container object. Here, the existence of the container object and collaborator object are tied together.

```ruby
class MyClass
  def initialize
    @collaborator_obj = MyOtherClass.new
  end
end

class MyOtherClass; end
```