$: << '.'

require 'rspec'
require 'graph'

describe 'Graph behaviour' do

  let(:graph) { Graph.new }

  it 'should load a graph from a file into a list of adjacency lists' do
    expected = [
        [2, 3, 4, 7],
        [1, 3, 4],
        [1, 2, 4],
        [1, 2, 3, 5],
        [4, 6, 7, 8],
        [5, 7, 8],
        [1, 5, 6, 8],
        [5, 6, 7]
    ]
    graph.load '2cut.txt'
    expect(graph.adj_list).to eq(expected)
  end
end