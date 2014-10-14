class Mergesort

  def sort(array)
    if array.size <= 1
      array
    else
      midpoint = array.size/2
      a1 = sort(array[0...midpoint])
      a2 = sort(array[midpoint...array.size])
      merge(a1, a2)
    end
  end

  private
  def merge(a1, a2)
    a = []
    i, j = 0, 0

    if a1.empty?
      a2
    elsif a2.empty?
      a1
    else
      while i < a1.size and j < a2.size do
        if a1[i] <= a2[j]
          a << a1[i]
          i += 1
        else
          a << a2[j]
          j += 1
        end
      end

      if i < a1.size
        a += a1[i...a1.size]
      elsif j < a2.size
        a += a2[j...a2.size]
      end

      a
    end
  end

end