require 'node'

class Edge
  attr_accessor :from
  attr_accessor :to

  def initialize(from, to)
    @from = from
    @to = to
  end

  def reverse
    swap(@from, @to)
  end

  private
  def swap(a, b)
    temp = b
    b = a
    a = temp
  end
end
