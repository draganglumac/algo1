$: << '.'
$: << '..'

require 'rspec'
require 'graph'

describe Graph do
  let(:graph) { Graph.new }

  describe 'should have weights in adjacency lists' do
    it 'should load adjacency list file correctly' do
      graph.load('test/small.txt')
      small = [nil,
               [[2, 3], [3, 3]],
               [[3, 1], [4, 2]],
               [[4, 50]],
               []]
      expect(graph.adj_list).to eq(small)

      graph.load('test/small2.txt')
      small2 = [nil,
               [[2, 3], [3, 5]],
               [[3, 1], [4, 2]],
               [[4, 50]],
               []]
      expect(graph.adj_list).to eq(small2)

      graph.load('test/medium.txt')
      medium = [nil,
                [[2, 7],  [3, 9],  [6, 14]],
                [[1, 7],  [3, 10], [4, 15]],
                [[1, 9],  [2, 10], [4, 11], [6, 2]],
                [[2, 15], [3, 11], [5, 6]],
                [[4, 6],  [6, 9]],
                [[1, 14], [3, 2],  [5, 9]]]
      expect(graph.adj_list).to eq(medium)
    end
  end

  before(:each) { graph.load('test/small.txt') }

  describe 'an edge should have a sink and length' do
    it 'should raise InvalidEdgeException if invalid edge sink' do
      expect { graph.sink(graph.edges_for_node(4).first) }.to raise_exception(InvalidEdgeException)
    end

    it 'should raise InvalidEdgeException if for invalid edge length' do
      expect { graph.length(graph.edges_for_node(4).first) }.to raise_exception(InvalidEdgeException)
    end

    it 'should return the sink node for valid edges' do
      expect(graph.sink(graph.edges_for_node(1).first)).to eq(2)
      expect(graph.sink(graph.edges_for_node(2).last)).to eq(4)
    end

    it 'should return the length for valid edges' do
      expect(graph.length(graph.edges_for_node(1).first)).to eq(3)
      expect(graph.length(graph.edges_for_node(2).last)).to eq(2)
    end
  end

  describe 'edges and nodes' do
    it 'should return empty list of edges of invalid node' do
      expect(graph.edges_for_node(0)).to eq([])
      expect(graph.edges_for_node(5)).to eq([])
    end

    it 'should return correct edges for valid node' do
      expect(graph.edges_for_node 1).to eq([[2, 3], [3, 3]])
      expect(graph.edges_for_node 3).to eq([[4, 50]])
      expect(graph.edges_for_node 4).to eq([])
    end

    it 'should return correct list of nodes' do
      expect(graph.nodes).to eq([1, 2, 3, 4])
      expect(graph.nodes.size).to eq(4)
    end
  end
end