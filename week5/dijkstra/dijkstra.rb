require 'graph'
require 'heap'

class Dijkstra
  attr_reader :from
  attr_reader :lengths

  def initialize
    @from = []
    @lengths = []
    @processed = {}
  end

  def duration_in_nanos(t1, t2)
    (1000000 * (t2 - t1)).to_i
  end

  suuuuuuuuuuuucks
  def quick_shortest_paths(graph, node)
    t1 = Time.now
    set_up graph, node
    heap = Heap.new { |a, b| a.first <=> b.first }
    heap.insert [0, node]
    until heap.empty?
      current = heap.extract_min[-1]
      unless @processed[current]
        curr_edges = graph.edges_for_node current
        curr_edges.each do |e|
          sink = graph.sink e
          len = graph.length e
          relax current, sink, len, heap
        end
      end
      @processed[current] = true
    end
    t2 = Time.now
    duration_in_nanos t1, t2
  end

  def relax(from, to, len, heap)
    path_len = @lengths[from] + len
    if @lengths[to].nil? or @lengths[to] > path_len
      @lengths[to] = path_len
      @from[to] = from
      heap.insert [path_len, to]
    end
  end

  def compute_shortest_paths(graph, node)
    t1 = Time.now
    set_up graph, node
    @processed[node] = true
    until all_nodes_processed(graph)
      update_score_for_next_node(graph)
    end
    t2 = Time.now
    duration_in_nanos t1, t2
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
