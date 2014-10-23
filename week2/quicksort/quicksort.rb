class Quicksort

  def sort(array)
    comparisons = 0
    unless array.nil? or array.empty?
      first = 0
      last = array.size - 1
      comparisons = quicksort(array, first, last, 0)
    end
    [array, comparisons]
  end

  private

  def quicksort(array, left, right, comparisons)
    if right > left
      split_index = partition(array, left, right)
      comparisons += (right - left)
      comparisons = quicksort(array, left, split_index - 1, comparisons)
      comparisons = quicksort(array, split_index + 1, right, comparisons)
    end
    comparisons
  end

  def partition(array, first, last)
    p = choose_index_of_pivot(array, first, last)
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

  def choose_index_of_pivot(array, first, last)
    # choose_random_index(first, last)
    # choose_first_index(first, last)
    # choose_last_index(first, last)
    choose_median_of_three(array, first, last)
  end

  def choose_random_index(first, last)
    if last - first > 1
      first + Random.rand(last - first)
    else
      first
    end
  end

  def choose_first_index(first, last)
    first
  end

  def choose_last_index(first, last)
    last
  end

  def calculate_midpoint(first, last)
    size = last - first + 1
    if size % 2 == 0
      first + size/2 - 1
    else
      first + size/2
    end
  end

  def choose_median_of_three(array, first, last)
    if last - first > 1
      smallest = median = first
      midpoint = calculate_midpoint(first, last)

      if array[first] < array[midpoint]
        median = midpoint
      else
        smallest = midpoint
      end

      if array[last] < array[smallest]
        median = smallest
      elsif array[last] < array[median]
        median = last
      end

      median
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
