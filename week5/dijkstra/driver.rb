$: << '.'

require 'pry'
require 'pry-nav'
require 'dijkstra'


def mn_dijkstra(dijkstra, graph, trials)
  results = []
  (0..trials).each do |i|
    results << dijkstra.compute_shortest_paths(graph, 1)
    puts results.last if i % 100 == 0
  end
  puts "Average running time for O(m*n) Dijkstra: #{results.reduce(:+) / results.size}"
end

def heap_dijkstra(dijkstra, graph, trials)
  results = []
  (0..trials).each do |i|
    results << dijkstra.quick_shortest_paths(graph, 1)
    puts results.last if i % 100 == 0
  end
  puts "Average running time for heap Dijkstra: #{results.reduce(:+) / results.size}"
end

graph = Graph.new
graph.load('test/dijkstraData.txt')

dijkstra = Dijkstra.new

mn_dijkstra dijkstra, graph, 1000
heap_dijkstra dijkstra, graph, 1000

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