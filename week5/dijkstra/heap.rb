require 'invariant'

class Heap
  attr_reader :heap

  def initialize
    @heap = []
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
      while @heap[parent] > @heap[current]
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
      c1 = (current + 1) * 2
      c2 = (current + 1) * 2 - 1
      while needs_a_swap?(current, c1, c2)
        if c2 >= @heap.size and c1 < @heap.size
          swap(current, c1)
          current = c1
        elsif c1 >= @heap.size and c2 < @heap.size
          swap(current, c2)
          current = c2
        else
          if @heap[c1] < @heap[c2]
            swap(current, c1)
            current = c1
          else
            swap(current, c2)
            current = c2
          end
        end
        c1 = (current + 1) * 2
        c2 = (current + 1) * 2 - 1
      end
    end
  end

  def needs_a_swap?(current, c1, c2)
    (c1 < @heap.size and @heap[current] > @heap[c1]) or
        (c2 < @heap.size and @heap[current] > @heap[c2])
  end

  def swap(a, b)
    temp = @heap[a]
    @heap[a] = @heap[b]
    @heap[b] = temp
  end

  def invariant
    result = true
    (0...@heap.size).each do |i|
      if (@heap[i % 2] > @heap[i])
        result = false
        break
      end
    end
    result
  end
end
