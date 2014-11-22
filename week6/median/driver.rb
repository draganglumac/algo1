$: << '.'

require 'median'

med = Median.new
sum = 0

File.open('Median.txt', 'r').each do |line|
  n = line.strip.to_i
  if n != 0 or (n == 0 and line.strip == '0')
    med.insert n
    sum += med.median
  end
end

puts "Running median is: #{sum % 10000}"