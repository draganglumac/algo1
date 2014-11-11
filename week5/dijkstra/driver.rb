$: << '.'

require 'pry'
require 'pry-nav'
require 'dijkstra'

graph = Graph.new
graph.load('test/dijkstraData.txt')

dijkstra = Dijkstra.new
dijkstra.compute_shortest_paths(graph, 1)

distances = [7, 37, 59, 82, 99, 115, 133, 165, 188, 197]
result = nil
distances.each do |d|
  unless result
    result = "#{dijkstra.lengths[d]}"
  else
    result += ",#{dijkstra.lengths[d]}"
  end
end
puts "Results:"
puts result