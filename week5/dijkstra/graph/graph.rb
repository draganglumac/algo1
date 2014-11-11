require 'node'
require 'edge'

class Graph
  def initialize
    @nodes = []
    @edges = []
  end

  def add_node(v)
    @nodes << v
  end

  def add_edge(e)
    @edges << e
  end
end

