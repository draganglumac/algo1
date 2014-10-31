require 'pry'
require 'pry-nav'

$: << '.'

require 'graph'
require 'min_cut'

class Driver
  def run
    min_cut = MinCut.new
    graph = Graph.new

    # graph.load('kargerMinCut.txt')
    graph.load('2cut.txt')

    n = graph.nodes.size
    num_tries = (n**2 * Math.log2(n)).to_i - 1
    puts "num_tries = #{num_tries}"
    puts ''

    cut = min_cut.compute_cut(graph)
    update_min_cut_size(cut)
    (0..num_tries).each do
      cut = min_cut.compute_cut(graph)
      update_min_cut_size(cut)
    end

    pretty_print(cut, @min_cut_size)
  end

  def update_min_cut_size(graph)
    cut_size = graph.edges_for_node(graph.nodes[0]).size
    @min_cut_size ||= cut_size
    @min_cut_size = cut_size if cut_size < @min_cut_size
    # puts "min, cut = #{@min_cut_size}, #{cut_size}"
  end

  def pretty_print(graph, cut)
    puts graph
    puts ''
    puts "Min cut size: #{cut}"
  end

end

Driver.new.run
