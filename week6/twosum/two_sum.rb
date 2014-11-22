class TwoSum

  def set_array(array)
    @array = array
    @indicators = {}
    @array.each { |e| @indicators[e] = true }
  end

  def load_array_from_file(file)
    array = []
    File.open(file, 'r').each do |line|
      n = line.strip.to_i
      if n == 0
        if line.strip == '0'
          array << n
        end
      else
        array << n
      end
    end
    set_array array
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
    # fast_distinct_sums(interval, result)
    hash_distinct_sums(interval, result)
    # two_loops_distinct_sums(interval, result)
    result.keys.sort
  end

  def fast_distinct_sums(interval, result)
    array = @array.sort
    max_j = array.size - 1
    min_i = 0

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