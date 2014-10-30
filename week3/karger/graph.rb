class Graph
  def initialize(raw_data)
    @graph = [] + raw_data
  end

  def self.load(filename)
    graph = []
    File.open(filename, 'r').each do |line|
      graph << line.strip.split(' ').map { |el| el.to_i } unless line.empty?
    end
    Graph.new graph.map { |e| e[1..-1].sort! }
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