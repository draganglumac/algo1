require 'graph'

class Dijkstra
  attr_reader :from
  attr_reader :lengths

  def initialize
    @from = []
    @lengths = []
    @processed = {}
  end

  def compute_shortest_paths(graph, node)
    set_up graph, node
    @processed[node] = true
    until all_nodes_processed(graph)
      update_score_for_next_node(graph)
    end
  end

  def set_up(graph, node)
    (0..graph.nodes.size).each do |i|
      if i == node
        @from << node
        @lengths << 0
      else
        @from << nil
        @lengths << nil
      end
    end
  end

  def all_nodes_processed(graph)
    @processed.size == graph.nodes.size
  end

  def update_score_for_next_node(graph)
    min_score, predecessor = nil, nil
    node = nil
    @processed.keys.each do |source|
      graph.edges_for_node(source).each do |edge|
        unless @processed[graph.sink(edge)]
          score = @lengths[source] + graph.length(edge)
          min_score ||= score
          predecessor ||= source
          if min_score >= score
            node = graph.sink edge
            min_score = score
            predecessor = source
          end
        end
      end
    end
    @processed[node] = true
    @from[node] = predecessor
    @lengths[node] = min_score
  end
end