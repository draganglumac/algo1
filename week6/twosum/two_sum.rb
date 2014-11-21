class TwoSum

  def pairs_for_sum(array, sum)
    indicators = {}
    array.each { |e| indicators[e] = true }

    pairs = []
    array.each do |e|
      if indicators[sum - e]
        pairs << [e, sum - e]
      end
    end

    pairs
  end

end