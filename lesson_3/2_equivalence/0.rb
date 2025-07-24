str1 = 'something'
str2 = 'something'
str1_copy = str1

str1.class # => String
str2.class # => String

p str1 == str2      # => true
p str1 == str1_copy # => true
p str2 == str1_copy # => true

p str1.equal?(str2)      # => false
p str1.equal?(str1_copy) # => true
p str2.equal?(str1_copy) # => false

int1 = 1
int2 = 1
p int1 == int2

sym1 = :something
sym2 = :something
p sym1 == sym2
