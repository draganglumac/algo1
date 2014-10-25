require 'pry'
require 'pry-nav'

$: << '.'
require 'quicksort'

class Array
  def middle
    self[self.size/2 - 1]
  end
end

class Driver
  def run
    a = []
    # File.open('IntegerArray.txt', 'r').each { |line| a << line.to_i }
    # File.open('IntegerArraySmall.txt', 'r').each { |line| a << line.to_i }
    File.open('QuickSort.txt', 'r').each { |line| a << line.to_i }
    # File.open('10.txt', 'r').each { |line| a << line.to_i }
    # File.open('100.txt', 'r').each { |line| a << line.to_i }
    # File.open('1000.txt', 'r').each { |line| a << line.to_i }
    # File.open('QuickSort100.txt', 'r').each { |line| a << line.to_i }
    # File.open('QuickSort1000.txt', 'r').each { |line| a << line.to_i }

    sorted, comparisons = Quicksort.new.sort a

    raise Exception.new('Sorted array is a different object to the original array!') unless a == sorted
    (0..(sorted.size - 2)).each do |i|
      if sorted[i] > sorted[i+1]
        raise Exception.new("Barf! In position #{i} you have #{sorted[i]} before #{sorted[i+1]}.")
      end
    end

    pretty_print sorted, comparisons
  end

  def pretty_print(a, comparisons)
    puts 'Stats:'
    puts '--------------------'
    printf "%s: %13d\n", 'First', a.first
    printf "%s: %12d\n", 'Middle', a.middle
    printf "%s: %14d\n", 'Last', a.last
    puts '--------------------'
    printf "%s: %14d\n", 'Size', a.size
    puts '--------------------'
    printf "%s: %7d\n", 'Comparisons', comparisons
  end

end

Driver.new.run
