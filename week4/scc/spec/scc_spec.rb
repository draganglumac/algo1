$: << '.'
$: << '..'

require 'rspec'
require 'graph'
require 'scc'

describe SCC do

  let(:graph) { Graph.new }
  let(:scc) { SCC.new }

  before(:each) { graph.load('test/small.txt') }

  it 'should compute finishing times' do
    scc.compute_finishing_times graph
    expect(scc.ftimes).to eq({1=>3, 2=>6, 3=>5, 4=>8, 5=>9, 6=>7, 7=>4, 8=>2, 9=>1})
    graph.clean_up_after_reversal
    expect(graph.adj_list).to eq([nil, [3], [1], [2], [2, 6], [4], [5], [4, 8], [9], [7]])
  end

  it 'should order nodes in descending finishing times' do
    scc.compute_finishing_times(graph)
    expect(scc.nodes_by_ftimes_desc).to eq([1, 2, 4, 7, 9, 8, 5, 6, 3])
  end

  it 'should compute strongly connected components' do
    expect(scc.get_SCCs graph).to eq([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
  end
end