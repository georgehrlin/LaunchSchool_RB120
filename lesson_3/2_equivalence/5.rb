num = 25

if (1..50) === num # "If (1..50) is agroup, would 25 belong in that group?"
  puts 'small number'
elsif (51..100) === num
  puts 'large number'
else
  puts 'not in range'
end

String === "hello" # => true # Because "hello" is an instance of String
String === 15      # => false
