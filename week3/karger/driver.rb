require 'pry'
require 'pry-nav'

$: << '.'

require 'graph'
require 'karger'

class Driver
  def run
    min_cut = MinCut.new
    graph = Graph.load('kargerMinCut.txt')
    cut = min_cut.compute_cut(graph)
    pretty_print(graph, cut)
  end

  def pretty_print(graph, cut)
    puts graph
    puts ''
    puts "Min cut: {#{cut}}"
  end

end

Driver.new.run
