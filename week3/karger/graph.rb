class InvalidEdgeException < Exception
end

class Graph
  def initialize
    @graph = [nil]
  end

  def adj_list
    @graph
  end

  def nodes
    nodes = []
    (1...@graph.size).each { |i| nodes << i unless @graph[i].nil? }
    nodes
  end

  def load(filename)
    File.open(filename, 'r').each do |line|
      unless line.empty?
        list = line.strip.split(' ').map { |el| el.to_i }
        @graph << list[1..-1].sort!
      end
    end
  end

  def to_s
    s = ''
    @graph.each do |el|
      unless el.nil?
        el.each { |e| s += '%3d ' % e }
        s[-1] = "\n"
      end
    end
    s
  end

  def valid_node(v)
    v > 0 and v < @graph.size and (not @graph[v].nil?)
  end

  def valid_edge(v1, v2)
    valid_node v1 and valid_node v2 and @graph[v1].member?(v2)
  end

  def contract_edge(v1, v2)
    unless valid_edge v1, v2
      raise InvalidEdgeException.new "Invalid edge (#{v1}, #{v2})"
    end

    v1_list = @graph[v1]
    @graph[v1] = nil
    replace_in_graph(v1, v2)
    v2_list = merge_lists_omitting(v1_list, @graph[v2], v2)
    @graph[v2] = v2_list.sort!
  end

  def replace_in_graph(v1, v2)
    @graph.each do |vl|
      unless vl.nil?
        i = vl.find_index(v1)
        until i.nil?
          vl[i] = v2
          i = vl.find_index(v1)
        end
        vl.sort!
      end
    end
  end

  def merge_lists_omitting(l1, l2, el_to_omit)
    result = l1 + l2
    result.sort!
    result.delete(el_to_omit)
    result
  end
end
