require 'pry'
require 'pry-nav'

$: << '.'

require 'graph'
require 'bfs'

class Driver
  def run
    bfs = BFS.new
    graph = Graph.new

    graph.load('kargerMinCut.txt')
    # graph.load('2cut.txt')
    # graph.load('2permuted.txt')
    # graph.load('1cut.txt')
    # graph.load('1permuted.txt')
    # graph.load('3cut.txt')
    # graph.load('3cut-small.txt')

    reachable_from_1 = bfs.nodes_reachable_from(graph, 1)
    dist, path = bfs.shortest_path(graph, 1, 38)
    pretty_print(reachable_from_1, [dist, path])
  end

  def pretty_print(nodes, shortest_path)
    p nodes
    puts ''
    puts "Number of reachable nodes = #{nodes.size}"
    puts ''
    p shortest_path
  end

end

Driver.new.run
