require 'invariant'

class Heap
  def initialize
    @heap = []
  end

  def heapify(array)
    array.each { |e| insert e }
    assert invariant
  end

  def insert(e)
    # ToDo
    assert invariant
  end

  def extract_min
    # ToDo
    assert invariant
  end

  def delete
    # ToDo
    assert invariant
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
