require 'stack'
require 'set'

class SCC
  attr_reader :ftimes
  attr_reader :visited

  def initialize
    @ftime = 0
    @visited = {}
    @ftimes = {}
    @current_component = []
    @strong_components = []
  end

  def get_SCCs(graph)
    compute_finishing_times graph
    compute_strong_components graph
  end

  def compute_finishing_times(graph)
    @strong_components = []
    graph.prepare_for_reversal
    graph.nodes.each { |node| dfs_visit(graph, node) }
    @ftime = 0
  end

  def compute_strong_components(graph)
    @visited = {}
    graph.prepare_for_reversal
    nodes_ft = nodes_by_ftimes_desc
    nodes_ft.each { |node| dfs_visit_component(graph, node) }
    @ftimes = {}
    @strong_components
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
    unless e.nil?
      until e.nil?
        dfs_visit(graph, e) if @visited[e].nil?
        e = pluck_and_reverse_first_edge(graph, node)
      end
      @ftime += 1
      @ftimes[@ftime] = node
    end
  end

  def dfs_visit_component(graph, node)
    unless @visited[node]
      @visited[node] = true
      @current_component << node
      e = pluck_and_reverse_first_edge(graph, node)
      unless e.nil?
        until e.nil?
          dfs_visit_component(graph, e) unless @visited[e]
          e = pluck_and_reverse_first_edge(graph, node)
        end
      end
      @strong_components << @current_component.sort unless @current_component.empty?
      @current_component = []
    end
  end

  def pluck_and_reverse_first_edge(graph, node)
    edges = graph.edges_for_node node
    unless edges.first.nil?
      e = edges.delete_at(0)
      graph.edges_for_node(e) << node
      e
    else
      nil
    end
  end
end
