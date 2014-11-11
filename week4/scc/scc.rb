require 'stack'
require 'set'

class SCC
  attr_reader :time
  attr_reader :finishing_times

  def initialize
    @time = 0
    @visited = {}
    @finishing_times = {}
    @strong_components = []
  end

  def get_SCCs(graph)
    compute_finishing_times graph
    compute_strong_components graph
  end

  def compute_finishing_times(graph)
    graph.prepare_for_reversal
    graph.nodes.each { |node| dfs_visit(graph, node) }
  end

  def compute_strong_components(graph)
    graph.prepare_for_reversal
    nodes_ft = nodes_in_decreasing_finishing_time
    nodes_ft.each { |node| dfs_visit(graph, node) }
  end

  def nodes_in_decreasing_finishing_time
    descending_ftimes = @finishing_times.keys.sort.reverse
    nodes_ft = []
    descending_ftimes.each { |k| nodes_ft << @finishing_times[k] }
    nodes_ft
  end
  
  private
  def dfs_visit(graph, node)
    @visited[node] = true
    @time += 1
    e = pluck_and_reverse_first_edge(graph, node)
    until e.nil?
      dfs_visit(graph, e) unless @visited[e]
      e = pluck_and_reverse_first_edge(graph, node)
    end
    @finishing_times[@time] = node
  end

  def pluck_and_reverse_first_edge(graph, node)
    edges = graph.edges_for_node node
    e = edges.remove(edges.first)
    graph.edges_for_node(e) << node
    e
  end
end
