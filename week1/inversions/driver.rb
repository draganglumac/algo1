require 'pry'
require 'pry-nav'

$: << '.'
require 'mergesort'

class Array
  def middle
    self[self.size/2 - 1]
  end
end

class Driver
  def run
    a = []
    # File.open('IntegerArray.txt', 'r').each { |line| a << line.to_i }
    File.open('IntegerArraySmall.txt', 'r').each { |line| a << line.to_i }

    sorted, inversions = Mergesort.new.sort a, 0

    (0..(sorted.size - 2)).each do |i|
      if sorted[i] > sorted[i+1]
        raise Exception.new("Barf! In position #{i} you have #{sorted[i]} before #{sorted[i+1]}.")
      end
    end

    pretty_print sorted, inversions
  end

  def pretty_print(a, inversions)
    puts 'Stats:'
    puts '--------------------'
    printf "%s: %13s\n", 'First', a.first
    printf "%s: %12s\n", 'Middle', a.middle
    printf "%s: %14s\n", 'Last', a.last
    printf "%s: %14s\n", 'Size', a.size
    puts '---------------'
    printf "%s: %8s\n", 'Inversions', inversions
  end

end

Driver.new.run