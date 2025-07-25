begin
  # put code at risk of failing here
rescue TypeError
  # take action
rescue ArgumentError
  # take a different action
rescue ZeroDivisionError, TypeError
  # take yet a different action
end

begin
  # code at risk of failing here
rescue StandardError => e # storing the exception object in e
  puts e.message          # output error message
end

rescue TypeError => e

e.class # => TypeError

file = open(file_name, 'w')

begin
  # do something with file
rescue
  # handle exception
rescue
  # handle a different exception
ensure
  file.close
  # executes every time
end

RETRY_LIMIT = 5

begin
  attempts = attempts || 0
  # do something
rescue
  attempts += 1
  retry if attempts < RETRY_LIMIT
end

raise TypeError.new('Something went wrong!')

raise TypeError, 'Something went wrong!'

def validate_age(age)
  raise('invalid age') unless (0..105).include?(age)
end

begin
  validate_age(age)
rescue RuntimeError => e
  puts e.message # >> invalid age
end

class ValidateAgeError < StandardError; end

def validate_age(age)
  raise ValidateAgeError, 'invalid age' unless (0..105).include?(age)
end

begin
  validate_age(age)
rescue ValidateAgeError => e
  # take action
end
