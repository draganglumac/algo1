class Graph

  def initialize(raw_data)
    @raw = raw_data
  end

  def self.load(filename)
    raw_data = []
    File.open(filename, 'r').each do |line|
      raw_data << line.strip.split(' ')
    end
    Graph.new(raw_data)
  end

  def to_s
    s = ''
    @raw.each do |el|
      s += "#{el.to_s}\n"
    end
    s
  end
end