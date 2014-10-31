$: << '.'
$: << '..'

require 'rspec'
require 'graph'
require 'min_cut'

describe 'MinCut' do

  let(:min_cut) { MinCut.new }
  let(:graph) { Graph.new}
  before(:each) { graph.load('2cut.txt') }

  it 'should randomly pick a node and an edge from that node' do
    g = spy('graph')
    allow(g).to receive(:nodes).and_return([1])
    expect(g).to receive(:nodes)
    expect(g).to receive(:edges_for_node).with(1)

    min_cut.pick_edge(g)
  end

  it 'should randomly choose an edge of a graph' do
    e = min_cut.pick_edge(graph)

    expect(graph.nodes).to include(e[0])
    expect(graph.edges_for_node(e[0])).to include(e[1])
  end

  it 'should only have 2 nodes left after computing a cut' do
    min_cut.compute_cut(graph)

    ns = graph.nodes
    expect(graph.nodes.size).to eq(2)
    expect(graph.edges_for_node(ns[0]).size).to eq(graph.edges_for_node(ns[1]).size)
  end
end