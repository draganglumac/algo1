require 'pry'
require 'pry-nav'

$: << '.'

require 'graph'
require 'scc'

class Driver
  def run
    scc = SCC.new
    graph = Graph.new

    # graph.load('test/small.txt')
    # graph.load('test/test.txt')

    start_time =  Time.new
    graph.load('test/SCC.txt')
    end_time = Time.new
    puts "- load took #{end_time - start_time} seconds."

    start_time = end_time
    sccs = scc.get_SCCs graph
    end_time = Time.new
    puts "- SCCs took #{end_time - start_time} seconds."

    if sccs.size < 100
      p sccs
      print_sizes_decreasing sccs
    else
      print_sizes_decreasing sccs, 5
    end
  end

  def print_sizes_decreasing(sccs, number=-1)
    sizes = sccs.map { |scc| scc.size }
    sizes.sort!.reverse!
    if number > 0
      puts "- Number of SCCs = #{sizes.size}"
      puts "Top #{number} sizes:"
      result = nil
      (0...number).each do |i|
        if result.nil?
          result ||= "#{sizes[i]}"
        else
          result += ",#{sizes[i]}"
        end
      end
      puts result
    else
      p sizes
    end
  end
end

Driver.new.run
