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
    graph.load('test/test.txt')
    # graph.load('test/SCC.txt')
# binding.pry
    sccs = scc.get_SCCs graph

    p sccs
    print_sizes_decreasing sccs
  end

  def print_sizes_decreasing(sccs)
    sizes = sccs.map { |scc| scc.size }
    p sizes.sort.reverse
  end
end

Driver.new.run
