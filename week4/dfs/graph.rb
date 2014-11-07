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

  def edges_for_node(n)
    @adj_list[n]
  end

  def load(filename)
    File.open(filename, 'r').each do |line|
      unless line.empty?
        list = line.strip.split(' ').map { |el| el.to_i }
        @adj_list << list[1..-1].sort!
      end
    end
  end

  def to_s
    s = ''
    i = 0
    @adj_list.each do |el|
      unless el.nil?
        s += '%3d -> ' % i
        el.each { |e| s += '%3d ' % e }
        s[-1] = "\n"
      end
      i += 1
    end
    s
  end

  def valid_node(v)
    v > 0 and v < @adj_list.size and (not @adj_list[v].nil?)
  end

  def valid_edge(v1, v2)
    valid_node v1 and valid_node v2 and @adj_list[v1].member?(v2)
  end

  def contract_edge(v1, v2)
    unless valid_edge v1, v2
      raise InvalidEdgeException.new "Invalid edge (#{v1}, #{v2})"
    end

    v1_list = @adj_list[v1]
    @adj_list[v1] = nil
    replace_in_graph(v1, v2)
    v2_list = merge_lists_omitting(v1_list, @adj_list[v2], v2)
    @adj_list[v2] = v2_list.sort!
  end

  def replace_in_graph(v1, v2)
    @adj_list.each do |vl|
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
