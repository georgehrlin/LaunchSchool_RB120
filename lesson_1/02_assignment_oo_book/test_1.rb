class ArabicaCoffee
attr_accessor :origin, :variety, :process

  def initialize(o, v, p)
    @origin = o
    @variety = v
    @process = p
  end

  def edit_info(o, v, p)
    origin = o
    variety = v
    process = p
  end

  def display_info
    puts "Origin: #{origin} | " +
         "Variety: #{variety} | " +
         "Process: #{process}"
  end
end

coffee1 = ArabicaCoffee.new('Panama', 'Gesha', 'Natural')
coffee1.display_info
coffee1.edit_info('Kenya', 'SL-28', 'Washed')
coffee1.display_info