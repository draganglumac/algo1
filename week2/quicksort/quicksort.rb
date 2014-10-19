class Quicksort

  def sort(array)
    unless array.nil? or array.empty?
      first = 0
      last = array.size - 1
      quicksort(array, first, last)
    end
    array
  end

  private

  def quicksort(array, left, right)
    if right > left
      split_index = partition(array, left, right)
      quicksort(array, left, split_index - 1)
      quicksort(array, split_index + 1, right)
    end
  end

  def partition(array, first, last)
    p = choose_index_of_pivot(first, last)
    swap(array, first, p) unless p == first

    i = j = first + 1
    while j <= last
      if array[j] < array[first]
        swap(array, i, j)
        i += 1
      end
      j += 1
    end

    pivot_place = i - 1
    swap(array, first, pivot_place)
    pivot_place
  end

  def choose_index_of_pivot(first, last)
    if last - first > 1
      first + Random.rand(last - first)
    else
      first
    end
  end

  def swap(array, i, j)
    unless i == j
      array[i] += array[j]
      array[j] = array[i] - array[j]
      array[i] -= array[j]
    end
  end
end
