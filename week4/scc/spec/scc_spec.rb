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
    p graph.adj_list
    scc.compute_finishing_times graph
    graph.clean_up_after_reversal
    p scc.ftimes
    p graph.adj_list
  end
end