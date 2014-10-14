class Mergesort

  def sort(array, inversions)
    if array.size <= 1
      [array, inversions]
    else
      midpoint = array.size/2
      a1, inv1 = sort(array[0...midpoint], 0)
      a2, inv2 = sort(array[midpoint...array.size], 0)
      merge(a1, a2, inversions + inv1 + inv2)
    end
  end

  private
  def merge(a1, a2, inversions)
    if a1.empty?
      [a2, inversions]
    elsif a2.empty?
      [a1, inversions]
    else
      merge_non_empty(a1, a2, inversions)
    end
  end

  def merge_non_empty(a1, a2, inversions)
    i, j = 0, 0
    a = []

    while i < a1.size and j < a2.size do
      if a1[i] <= a2[j]
        a << a1[i]
        i += 1
      else
        a << a2[j]
        j += 1
        inversions += 1
      end
    end

    if i < a1.size
      a += a1[i...a1.size]
      inversions += (a1.size - i -1)
    elsif j < a2.size
      a += a2[j...a2.size]
    end
    [a, inversions]
  end

end