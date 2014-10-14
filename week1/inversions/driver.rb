require 'pry'
require 'pry-nav'

$: << '.'
require 'mergesort'

class Driver
  def run
    a = []
    File.open('IntegerArray.txt', 'r').each { |line| a << line.to_i }

    sorto = Mergesort.new
    a = sorto.sort a

    (0..99998).each do |i|
      if a[i] > a[i+1]
        puts "Shit, no good! In position #{i} we have #{a[i]} before #{a[i+1]}"
      end
    end

    pretty_print a
    puts 'Done!'
  end

  def pretty_print(a)
    puts "First:  #{a[0]}"
    puts "Last:   #{a[a.size-1]}"
    puts "Length: #{a.size}"
  end

end

Driver.new.run