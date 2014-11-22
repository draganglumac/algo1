require 'heap'

class Median

  def initialize
    reset
  end

  def reset
    @lo_heap = Heap.new { |a, b| b <=> a }
    @hi_heap = Heap.new { |a, b| a <=> b }
  end

  def median
    size = (@lo_heap.heap.size + @hi_heap.heap.size)
    if size % 2 == 1
      m = (size + 1) / 2
    else
      m = size / 2
    end

    if m > @lo_heap.heap.size
      @hi_heap.top
    else
      @lo_heap.top
    end
  end

  def insert(n)
    if @lo_heap.empty?
      @lo_heap.insert n
    elsif n > @lo_heap.top
      @hi_heap.insert n
    else
      @lo_heap.insert n
    end

    if @lo_heap.heap.size > (@hi_heap.heap.size + 1)
      @hi_heap.insert(@lo_heap.extract_top)
    elsif @hi_heap.heap.size > (@lo_heap.heap.size + 1)
      @lo_heap.insert(@hi_heap.extract_top)
    end
  end
end