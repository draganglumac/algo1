$: << '.'

require 'two_sum'

two_sum = TwoSum.new
two_sum.load_array_from_file 'algo1-programming_prob-2sum.txt'
result = two_sum.distinct_sums -10000..10000
p result
puts "The number of distinct sums: #{result.size}"