require 'pry'
require 'pry-nav'

$: << '.'

require 'graph'
require 'scc'

class Driver
  def run
    scc = SCC.new
    graph = Graph.new

    # graph.load('small.txt')
    graph.load('test.txt')
    # graph.load('SCC.txt')

    edges = 0
    graph.nodes.each do |node|
      graph.edges_for_node(node).each do |e|
        edges += 1
      end
    end
    puts "nodes = #{graph.nodes.size}"
    puts "edges = #{edges}"

    reachable_from_1 = scc.dfs(graph, 1)
    reverse_from_1 = scc.reverse_dfs(graph, 1)

    if graph.nodes.size < 1000
      puts graph
      pretty_print(reachable_from_1)
      pretty_print(reverse_from_1)
    else
      if reverse_from_1 == reachable_from_1.reverse
        puts 'The list is reversed'
      end
    end
  end

  def pretty_print(nodes)
    puts ''
    p nodes
    puts "Number of reachable nodes = #{nodes.size}"
  end

end

Driver.new.run
