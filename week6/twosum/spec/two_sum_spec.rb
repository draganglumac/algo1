$: << '.'
$: << '..'

require 'rspec'
require 'two_sum'

describe TwoSum do

  let(:two_sum) { TwoSum.new }

  it 'should return empty result for empty array' do
    two_sum.set_array []
    expect(two_sum.pairs_for_sum 2709).to eq([])
  end

  it 'should return empty result for array with one element' do
    two_sum.set_array [1]
    expect(two_sum.pairs_for_sum 2709).to eq([])
  end

  it 'should return a pair of elements that sums up to the sum' do
    two_sum.set_array [1, 1, 2000, 2, 709]
    expect(two_sum.pairs_for_sum 2709).to eq([[2000, 709], [709, 2000]])
  end

  it 'should return distinct sums for an interval' do
    two_sum.set_array [1, 2000, 2, 709]
    expect(two_sum.distinct_sums 0..2800).to eq([3, 710, 711, 2001, 2002, 2709])
  end

  describe 'tests from discussion forums' do
    def run_test(two_sum, file, output)
      two_sum.load_array_from_file file
      expect(two_sum.distinct_sums -10000..10000).to eq(output)
    end

    it 'should pass test 1' do
      run_test two_sum, 'test/test1.txt', [-10000, -9999, 1, 2, 3]
    end

    it 'should pass test 2' do
      run_test two_sum, 'test/test2.txt', [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14]
    end
  end

end