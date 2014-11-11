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
    graph.load('test/SCC.txt')

    sccs = scc.get_SCCs graph

    if sccs.size < 100
      p sccs
      print_sizes_decreasing sccs
    else
      print_sizes_decreasing sccs, 10
    end
  end

  def print_sizes_decreasing(sccs, number=-1)
    sizes = sccs.map { |scc| scc.size }
    sizes.sort!.reverse!
    if number > 0
      puts "Number of SCCs = #{sizes.size}"
      puts "First #{number} sizes:"
      result = ''
      (0...number).each { |i| result = "#{result},#{sizes[i]}" }
      puts result
    else
      p sizes
    end
  end
end

Driver.new.run
