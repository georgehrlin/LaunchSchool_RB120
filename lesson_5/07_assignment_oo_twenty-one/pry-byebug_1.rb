require 'pry-byebug'

def count_letters(str, char)
  str.count(char)
end

def single_letters(str)
  binding.pry
  singles = []
  str.chars.each do |char|
    letter_count = count_letters(str, char)

    singles << if letter_count == 1
  end

  singles
  end
end

p single_letters('Cool cat') == ['l', ' ', 'a', 't']
