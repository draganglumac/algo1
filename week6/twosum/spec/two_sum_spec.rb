$: << '.'
$: << '..'

require 'rspec'
require 'two_sum'

describe TwoSum do

  let(:two_sum) { TwoSum.new }

  it 'should return empty result for empty array' do
    expect(two_sum.pairs_for_sum [], 2709).to eq([])
  end

  it 'should return empty result for array with one element' do
    expect(two_sum.pairs_for_sum([1], 2709)).to eq([])
  end

  it 'should return a pair of elements that sums up to the sum' do
    expect(two_sum.pairs_for_sum [1, 2000, 2, 709], 2709).to eq([[2000, 709], [709, 2000]])
  end
end