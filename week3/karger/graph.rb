class Graph
  attr_accessor :num_nodes

  def initialize
    @graph = []
    @num_nodes = 0
  end

  def adj_list
    @graph
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
      el.each { |e| s += '%3d ' % e }
      s[-1] = "\n"
    end
    s
  end
end