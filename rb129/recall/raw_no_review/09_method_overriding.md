# Method Overriding
Because of inheritance and how method lookup works in Ruby, we can override and customize a pre-existing method by creating a method that shares the same name. 

A common method to be overriden is `to_s`.

```ruby
class PCDIY
  def initialize(cpu, gpu)
    @cpu = cpu
    @gpu = gpu
  end

  def to_s
    puts "CPU: #{@cpu} | GPU: #{@gpu}"
  end
end

pc = PCDIY.new('AMD 9950X3D', 'Asus ROG Astral OC RTX 5090')
puts pc # Output: CPU: AMD 9950X3D | GPU: Asus ROG Astral OC RTX 5090

# Without DIY#to_s, the output would instead be: #<PCDIY:0x00000001051a2510>
```
