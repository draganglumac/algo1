class InversionCounter

  def sort_and_count(array, invs)
    if array.size <= 1
      [array, invs]
    else
      midpoint = array.size/2
      a1, inv1 = sort_and_count(array[0...midpoint], 0)
      a2, inv2 = sort_and_count(array[midpoint...array.size], 0)
      merge_and_count_split_inv(a1, a2, invs + inv1 + inv2)
    end
  end

  private
  def merge_and_count_split_inv(a1, a2, invs)
    if a1.empty?
      [a2, invs]
    elsif a2.empty?
      [a1, invs]
    else
      merge_non_empty(a1, a2, invs)
    end
  end

  def merge_non_empty(a1, a2, invs)
    i, j = 0, 0
    a = []
    merge_size = a1.size + a2.size

    (0...merge_size).each do |k|
      if i == a1.size
        a += a2[j...a2.size]
        break
      elsif j == a2.size
        a += a1[i...a1.size]
        break
      else
        if a1[i] <= a2[j]
          a[k] = a1[i]
          i += 1
        else
          a[k] = a2[j]
          invs += (a1.size - i)
          j += 1
        end
      end
    end

    [a, invs]
  end

end