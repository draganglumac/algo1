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
    File.open('IntegerArray.txt', 'r').each { |line| a << line.to_i }

    sorted = Mergesort.new.sort a

    (0..99998).each do |i|
      if sorted[i] > sorted[i+1]
        raise Exception.new("Barf! In position #{i} you have #{sorted[i]} before #{sorted[i+1]}.")
      end
    end

    pretty_print sorted
  end

  def pretty_print(a)
    puts 'Stats:'
    puts '---------------'
    printf "%s: %8s\n", 'First', a.first
    printf "%s: %7s\n", 'Middle', a.middle
    printf "%s: %9s\n", 'Last', a.last
    puts '---------------'
    printf "%s: %9s\n", 'Size', a.size
  end

end

Driver.new.run