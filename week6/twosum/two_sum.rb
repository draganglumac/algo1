class TwoSum

  def set_array(array)
    reset
    @array = array
    @array.each { |e| @indicators[e] = true }
  end

  def load_distinct_from_file(file)
    reset
    File.open(file, 'r').each do |line|
      n = line.strip.to_i
      if n == 0
        if line.strip == '0'
          add_number(n)
        end
      else
        add_number(n)
      end
    end
  end

  def reset
    @array = []
    @indicators = {}
  end

  def add_number(n)
    unless @indicators[n]
      @array << n
      @indicators[n] = true
    end
  end

  def pairs_for_sum(sum)
    pairs = []
    unless @array.nil? or @array.empty?
      @array.each do |e|
        if @indicators[sum - e]
          pairs << [e, sum - e] unless sum == 2 * e
        end
      end
    end
    pairs
  end

  def distinct_sums(interval)
    result = {}
    fast_distinct_sums(interval, result)
    # hash_distinct_sums(interval, result)
    # two_loops_distinct_sums(interval, result)
    result.keys.sort
  end

  def fast_distinct_sums(interval, result)
    array = @array.sort
    right = array.size - 1
    left = 0
    while left <= right
      while (array[left] + array[right]) > interval.last
        break if left > right
        right -= 1
      end
      j = right
      until (array[left] + array[j]) < interval.first
        break if left > j
        result[array[left] + array[j]] = true unless array[left] == array[j]
        j -= 1
      end
      left += 1
    end
  end

  def hash_distinct_sums(interval, result)
    interval.each do |sum|
      @array.each do |n|
        unless sum == 2 * n
          if @indicators[sum - n]
            result[sum] = true
            break
          end
        end
      end
    end
  end

  def two_loops_distinct_sums(interval, result)
    i = 0
    j = 1
    (i...@array.size).each do |first|
      (j...@array.size).each do |second|
        unless @array[first] == @array[second]
          sum = @array[first] + @array[second]
          result[sum] = true if interval.first <= sum and sum <= interval.last
        end
      end
    end
  end

end