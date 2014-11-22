$: << '.'
$: << '..'

require 'rspec'
require 'median'

describe Median do

  let(:med) { Median.new }

  it 'should return nil for median of an empty array' do
    expect(med.median).to be_nil
  end

  it 'should return the inserted element if only one is inserted' do
    med.insert 42
    expect(med.median).to eq(42)
  end

  it 'should return the size/2-th element if size is even' do
    med.insert 42
    med.insert 13
    expect(med.median).to eq(13)

    med.insert(15)
    med.insert(17)
    expect(med.median).to eq(15)
  end

  it 'should return the (size + 1)/2-th element if size is odd' do
    med.insert 42
    med.insert 13
    med.insert 15
    expect(med.median).to eq(15)

    med.insert(24)
    med.insert(17)
    expect(med.median).to eq(17)

    med.insert(18)
    expect(med.median).to eq(17)

    med.insert(13)
    med.insert(3)
    expect(med.median).to eq(15)
  end

  it 'should work out running median for array 1' do
    array = [4, 5, 6, 7, 8, 9, 10, 1, 2, 3]
    sum = 0
    array.each do |n|
      med.insert n
      sum += med.median
    end

    expect(sum).to eq(54)
  end
end