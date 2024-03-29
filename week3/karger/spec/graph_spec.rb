$: << '.'
$: << '..'

require 'rspec'
require 'graph'
require 'pry'
require 'pry-nav'

describe 'Graph behaviour' do

  let(:graph) { Graph.new }
  before(:each) { graph.load('2cut.txt') }

  it 'should load a graph from a file into a list of adjacency lists' do
    expected = [
        nil,
        [2, 3, 4, 7],
        [1, 3, 4],
        [1, 2, 4],
        [1, 2, 3, 5],
        [4, 6, 7, 8],
        [5, 7, 8],
        [1, 5, 6, 8],
        [5, 6, 7]
    ]
    expect(graph.adj_list).to eq(expected)
  end

  it 'should contract an edge 1, 4 correctly' do
    expected = [
        nil,
        nil,
        [3, 4, 4],
        [2, 4, 4],
        [2, 2, 3, 3, 5, 7],
        [4, 6, 7, 8],
        [5, 7, 8],
        [4, 5, 6, 8],
        [5, 6, 7]
    ]
    graph.contract_edge(1, 4)
    expect(graph.adj_list).to eq(expected)
  end

  it 'should contract to the correct graph after series of cuts' do
    expected = [
        nil,
        nil,
        nil,
        nil,
        [7, 7],
        nil,
        nil,
        [4, 4],
        nil
    ]
    graph.contract_edge 1, 4
    graph.contract_edge 5, 7
    graph.contract_edge 3, 4
    graph.contract_edge 6, 7
    graph.contract_edge 2, 4
    graph.contract_edge 8, 7
    expect(graph.adj_list).to eq(expected)
  end

  it 'should contract to the correct graph after different series of cuts' do
    expected = [
        nil,
        nil,
        nil,
        nil,
        [7, 7],
        nil,
        nil,
        [4, 4],
        nil
    ]
    graph.contract_edge 1, 4
    graph.contract_edge 5, 7
    graph.contract_edge 2, 4
    graph.contract_edge 8, 7
    graph.contract_edge 3, 4
    graph.contract_edge 6, 7
    expect(graph.adj_list).to eq(expected)
  end

  it 'should raise InvalidEdgeException if an attempt is made to contract a non-existant edge' do
    expect { graph.contract_edge(0, 7) }.to raise_exception(InvalidEdgeException)
    expect { graph.contract_edge(1, 8) }.to raise_exception(InvalidEdgeException)

    graph.contract_edge(1, 4)
    expect { graph.contract_edge(3, 1) }.to raise_exception(InvalidEdgeException)
  end

  it 'should return a list of nodes ignoring nil nodes' do
    expect(graph.nodes).to eq([1, 2, 3, 4, 5, 6, 7, 8])

    graph.contract_edge(4, 1)
    expect(graph.nodes).to eq([1, 2, 3, 5, 6, 7, 8])

    graph.contract_edge(1, 3)
    expect(graph.nodes).to eq([2, 3, 5, 6, 7, 8])
  end

  it 'should return edges for node' do
    expect(graph.edges_for_node 0).to be_nil
    expect(graph.edges_for_node 1).to eq([2, 3, 4, 7])
    expect(graph.edges_for_node 19).to be_nil

    graph.contract_edge(4, 1)
    expect(graph.edges_for_node 1).to eq([2, 2, 3, 3, 5, 7])
    expect(graph.edges_for_node 4).to be_nil
  end
end