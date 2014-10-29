require 'pry'
require 'pry-nav'

$: << '.'

require 'graph'
require 'karger'

class Driver
  def run
    min_cut = MinCut.new
    graph = Graph.load('kargerMinCut.txt')
    puts graph
    min_cut.compute_cut(graph)

    pretty_print
  end

  def pretty_print
    puts 'ToDo'
  end

end

Driver.new.run
