class PCDIY
  include Comparable

  attr_reader :gpu

  def initialize(cpu, gpu)
    @cpu = cpu
    @gpu = gpu
  end

  def show_cpu
    puts @cpu
  end

  private

  def show_gpu
    puts @gpu
  end

  protected

  def <=>(other)
    case
    when @gpu[-4..] > other.gpu[-4..] then 1
    when @gpu[-4..] < other.gpu[-4..] then -1
    when @gpu[-4..] == other.gpu[-4..] then 0
    end
  end
end

pc1 = PCDIY.new('AMD 7600X', 'RTX 5070')
pc2 = PCDIY.new('AMD 9800X3D', 'RTX 5060')

p pc1 > pc2