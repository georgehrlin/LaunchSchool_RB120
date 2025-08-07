=begin
joinor

joinor([1])                      # => "1"
joinor([1, 2])                   # => "1 or 2"
joinor([1, 2], ';')              # => "1 or 2"
joinor([1, 2], ',', 'and')       # => "1 and 2"
joinor([1, 2, 3])                # => "1, 2, or 3"
joinor([1, 2, 3], '; ')          # => "1; 2; or 3"
joinor([1, 2, 3], ', ', 'and')   # => "1, 2, and 3"
=end

=begin
PEDAC
P
Input:
  - An arr
  - OR: An arr and a str
  - OR: An arr, a str, and a str
Output:
  - If input arr has two eles
    - A str: "(1st ele) or (2nd ele)"
  - If input arr has three or more eles
    - A str: "(1st ele), (2nd ele), ..., or (last ele)"
    - Eles in output str are separated by "," except the last two, which is
      separated by "or"
  - If input is arr and a str
    - A str: "(1st ele)(input str) (2nd ele)(input str) ... (input str) or (last ele)"
    - Eles in output str are separated by input str, except the last two, which
      is spearated by "or"
  - If input is arr, str1, str2
    - A str: "(1st ele)(str1) (2nd ele)(str1) ... (str2)"

A
- Method should accept three parameters
  - 1st para always points to an arr
  - 2nd para is a "separator", default val: ','
  - 3rd para is "last separator", default val: 'or'
- Determine the size of input arr
  - If <= 2
    - Call Array#join with 3rd para as argument on input arr
  - If > 2
    - Call Array#join with 2nd para as argument on all eles of input arr excpet
      the last ele
    - Concatenate return str of join with 3rd para and last ele
=end

def joinor(arr, separator = ',', last_separator = 'or')
  if arr.size <= 2
    arr.join(" #{last_separator} ")
  else
    arr[...-1].join("#{separator} ") +
    "#{separator} #{last_separator} #{arr.last}"
  end
end

# p joinor([1])                    # == "1"
# p joinor([1, 2])                 # == "1 or 2"
# p joinor([1, 2], ';')            # == "1 or 2"
# p joinor([1, 2], ',', 'and')     # == "1 and 2"
# p joinor([1, 2, 3])              # == "1, 2, or 3"
# p joinor([1, 2, 3], ';')        # == "1; 2; or 3"
# p joinor([1, 2, 3], ',', 'and') # == "1, 2, and 3"

class Array
  def joinor(separator = ',', last_separator = 'or')
    if size <= 2
      join(" #{last_separator} ")
    else
      self[...-1].join("#{separator} ") +
      "#{separator} #{last_separator} #{last}"
    end
  end
end

p [1].joinor                    # == "1"
p [1, 2].joinor                 # == "1 or 2"
p [1, 2].joinor(';')             # == "1 or 2"
p [1, 2].joinor(',', 'and')     # == "1 and 2"
p [1, 2, 3].joinor              # == "1, 2, or 3"
p [1, 2, 3].joinor(';')        # == "1; 2; or 3"
p [1, 2, 3].joinor(',', 'and') # == "1, 2, and 3"
