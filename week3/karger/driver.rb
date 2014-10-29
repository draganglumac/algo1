require 'pry'
require 'pry-nav'

$: << '.'

require 'graph'
require 'karger'

class Driver
  def run
    min_cut = MinCut.new
    graph = Graph.load('kargerMinCut.txt')
    min_cut.compute_cut(graph)
    pretty_print(graph)
  end

  def pretty_print(graph)
    puts graph
  end

end

Driver.new.run
