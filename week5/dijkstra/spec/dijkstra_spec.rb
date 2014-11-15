$: << '.'
$: << '..'

require 'rspec'
require 'dijkstra'

describe Dijkstra do
  let(:graph) { Graph.new }
  let(:dijkstra) { Dijkstra.new }

  before(:each) { graph.load('test/small.txt') }

  it 'should initialise properly for a given graph' do
    dijkstra.set_up graph, 3
    expect(dijkstra.from).to eq([nil, nil, nil, 3, nil])
    expect(dijkstra.lengths).to eq([nil, nil, nil, 0, nil])
  end

  it 'should compute shortest paths correctly' do
    # graph.load('test/small2.txt')
    # graph.load('test/small3.txt')
    # graph.load('test/small4.txt')
    # graph.load('test/medium.txt')
    graph.load('test/medium2.txt')
    dijkstra.compute_shortest_paths(graph, 1)
    # dijkstra.quick_shortest_paths(graph, 1)
    p dijkstra.from
    p dijkstra.lengths
  end
end