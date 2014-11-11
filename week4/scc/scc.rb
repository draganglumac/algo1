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
    unless @visited[node]
      stack = Stack.new
      @visited[node] = true
      stack.push node
      until stack.empty?
        top = stack.top
        e = pluck_and_reverse_first_edge(graph, top)
        if e.nil?
          @ftime += 1
          @ftimes[@ftime] = stack.pop
        else
          unless @visited[e]
            @visited[e] = true
            stack.push e
          end
        end
      end
    end
  end

  def dfs_visit_component(graph, node)
    # p ['node', node]
    unless @visited[node]
      stack = Stack.new
      @visited[node] = true
      stack.push node
      @current_component << node
      # p ['stack', stack.to_a]
      until stack.empty?
        top = stack.top
        e = pluck_and_reverse_first_edge graph, top
        unless e.nil?
          unless @visited[e]
            @current_component << e
            @visited[e] = true
            stack.push e
            # p ['stack', stack.to_a]
          end
        else
          stack.pop
        end
      end
      # p ['cc', @current_component]
      @strong_components << @current_component.sort unless @current_component.empty?
      @current_component = []
    end
    # p 'returning'
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
