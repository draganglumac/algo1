require 'stack'
require 'set'

class SCC
  attr_reader :ftimes

  def initialize
    @ftime = 0
    @visited = {}
    @ftimes = {}
    @strong_components = []
  end

  def get_SCCs(graph)
    compute_finishing_times graph
    compute_strong_components graph
  end

  def compute_finishing_times(graph)
    graph.prepare_for_reversal
    graph.nodes.each { |node| dfs_visit(graph, node) }
    @ftime = 0
  end

  def compute_strong_components(graph)
    graph.prepare_for_reversal
    nodes_ft = nodes_by_ftimes_desc
    nodes_ft.each { |node| dfs_visit(graph, node) }
    @ftimes = {}
  end

  def nodes_by_ftimes_desc
    descending_ftimes = @ftimes.keys.sort.reverse
    nodes_ft = []
    descending_ftimes.each { |k| nodes_ft << @ftimes[k] }
    nodes_ft
  end

  def dfs_visit(graph, node)
    @visited[node] = true
    e = pluck_and_reverse_first_edge(graph, node)
    until e.nil?
      dfs_visit(graph, e) unless @visited[e]
      e = pluck_and_reverse_first_edge(graph, node)
    end
    @ftime += 1
    @ftimes[node] = @ftime
  end

  def pluck_and_reverse_first_edge(graph, node)
    edges = graph.edges_for_node node
    unless edges.first.nil?
      e = edges.delete(edges.first)
      graph.edges_for_node(e) << node
      e
    else
      nil
    end
  end
end
