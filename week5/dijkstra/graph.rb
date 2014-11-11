class InvalidEdgeException < Exception
end

class Graph
  attr_accessor :adj_list

  def initialize
    @adj_list = [nil]
  end

  def clone
    g = Graph.new
    new_list = []
    @adj_list.each do |el|
      if el.nil?
        new_list << nil
      else
        new_list << el.clone
      end
    end
    g.adj_list = new_list
    g
  end

  def nodes
    nodes = []
    (1...@adj_list.size).each { |i| nodes << i unless @adj_list[i].nil? }
    nodes
  end

  def length(edge)
    edge.last if valid_edge(edge)
  end

  def sink(edge)
    edge.first if valid_edge(edge)
  end

  def valid_edge(edge)
    raise InvalidEdgeException.new("Invalid edge: #{edge}") if (edge.nil? or edge.empty? or edge.size != 2)
    true
  end

  def edges_for_node(n)
    @adj_list[n] || []
  end

  def load(filename, sorted=false)
    @adj_list = [nil]
    File.open(filename, 'r').each do |line|
      unless line.empty?
        list = line.strip.split(/\s+/).map { |el| el.split(',').map { |e| e.to_i } }
        add_to_node(list.first.first.to_i, list[1..-1])
      end
    end
  end

  def add_to_node(node, edges)
    @adj_list[node] ||= []
    @adj_list[node] += edges
  end

  def to_s
    s = ''
    i = 0
    @adj_list.each do |el|
      unless el.nil?
        s += '%3d -> ' % i
        s += el.to_s
        s += "\n"
      end
      i += 1
    end
    s
  end

end
