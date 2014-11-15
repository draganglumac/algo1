require 'invariant'

class Heap
  attr_reader :heap

  def initialize(&compare)
    @heap = []
    @compare = compare
  end

  def empty?
    @heap.empty?
  end

  def heapify(array)
    array.each { |e| insert e }
    assert invariant
  end

  def insert(e)
    @heap << e
    bubble_up
    assert invariant
  end

  def extract_min
    min = nil
    unless @heap.empty?
      min = @heap[0]
      @heap[0] = @heap[-1]
      @heap.delete_at(-1)
      bubble_down
      assert invariant
    end
    min
  end

  def bubble_up
    unless @heap.empty?
      current = @heap.size - 1
      parent = current / 2
      while @compare.call(@heap[parent], @heap[current]) > 0
        break if parent == current
        swap(current, parent)
        current /= 2
        parent /= 2
      end
    end
  end

  def bubble_down
    unless @heap.empty?
      current = 0
      c1 = 2 * current + 1
      c2 = 2 * current + 2
      while needs_a_swap?(current, c1, c2)
        if c2 >= @heap.size and c1 < @heap.size
          swap(current, c1)
          current = c1
        elsif c1 >= @heap.size and c2 < @heap.size
          swap(current, c2)
          current = c2
        else
          if @compare.call(@heap[c1], @heap[c2]) < 0
            swap(current, c1)
            current = c1
          else
            swap(current, c2)
            current = c2
          end
        end
        c1 = 2 * current + 1
        c2 = 2 * current + 2
      end
    end
  end

  def needs_a_swap?(current, c1, c2)
    (c1 < @heap.size and @compare.call(@heap[current], @heap[c1]) > 0) or
        (c2 < @heap.size and @compare.call(@heap[current], @heap[c2]) > 0)
  end

  def swap(a, b)
    temp = @heap[a]
    @heap[a] = @heap[b]
    @heap[b] = temp
  end

  def invariant
    result = true
    (@heap.size...0).each do |i|
      if (@compare.call(@heap[i % 2], @heap[i])) > 0
        puts ''
        puts 'Offending heap -> '
        p @heap
        puts "Element #{@heap[i % 2]}@#{i % 2} is greater than its child #{@heap[i]}@#{i}!"
        result = false
        break
      end
    end
    result
  end
end
