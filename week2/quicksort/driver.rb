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

    sorted = Quicksort.new.sort a

    raise Exception.new('Sorted array is a different object to the original array!') unless a == sorted
    (0..(sorted.size - 2)).each do |i|
      if sorted[i] > sorted[i+1]
        raise Exception.new("Barf! In position #{i} you have #{sorted[i]} before #{sorted[i+1]}.")
      end
    end

    pretty_print sorted
  end

  def pretty_print(a)
    puts 'Stats:'
    puts '--------------------'
    printf "%s: %13s\n", 'First', a.first
    printf "%s: %12s\n", 'Middle', a.middle
    printf "%s: %14s\n", 'Last', a.last
    puts '--------------------'
    printf "%s: %14s\n", 'Size', a.size
  end

end

Driver.new.run

# First submission 14/10/2014  19:50 -> 2499690537
# Second submission 14/10/2014 20:06 -> 2407905288 - correct
