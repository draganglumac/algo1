$: << '.'
$: << '..'

require 'rspec'
require 'graph'

describe 'Graph behaviour' do

  let(:graph) { Graph.new }
  before(:each) { graph.load('2cut.txt') }
  # --1
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
  # --2
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
end