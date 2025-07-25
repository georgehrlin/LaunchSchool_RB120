my_array = %w(hello world)
my_array << '!!'
puts my_array.inspect # => ["hello", "world", "!!"]

my_hash = {a: 1, b: 2, c: 3}
my_hash << {d: 4} # NoMethodError
