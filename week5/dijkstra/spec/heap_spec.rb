$: << '.'
$: << '..'

require 'rspec'
require 'heap'

describe Heap do
  let(:heap) { Heap.new { |a, b| a <=> b } }

  describe 'insert' do
    it 'should insert first element into root position' do
      heap.insert 3
      expect(heap.heap.first).to eq(3)
      expect(heap.heap.size).to eq(1)
    end

    describe 'empty heap' do
      it 'should be empty intially' do
        expect(heap.empty?).to be_truthy
      end
    end

    describe 'non empty heap' do
      before(:each) do
        heap.insert 3
        heap.insert 5
        heap.insert 1
        heap.insert 2
        heap.insert 10
        heap.insert 7
      end

      it 'should insert elements so that heap property is preserved' do
        expect(heap.heap).to eq([1, 2, 3, 5, 10, 7])
      end

      it 'should decrease key' do
        heap.decrease_key(6, 15)
        expect(heap.heap).to eq([1, 2, 3, 5, 10, 7])

        heap.decrease_key(0, 0)
        expect(heap.heap).to eq([0, 2, 3, 5, 10, 7])

        heap.decrease_key(4, 1)
        expect(heap.heap).to eq([0, 1, 3, 5, 2, 7])
      end

      it 'should extract minimum' do
        min = heap.extract_min
        expect(min).to eq(1)
        expect(heap.heap).to eq([2, 5, 3, 7, 10])

        min = heap.extract_min
        expect(min).to eq(2)
        expect(heap.heap).to eq([3, 5, 10, 7])

        min = heap.extract_min
        expect(min).to eq(3)
        expect(heap.heap).to eq([5, 7, 10])

        min = heap.extract_min
        expect(min).to eq(5)
        expect(heap.heap).to eq([7, 10])

        min = heap.extract_min
        expect(min).to eq(7)
        expect(heap.heap).to eq([10])

        min = heap.extract_min
        expect(min).to eq(10)
        expect(heap.heap).to eq([])

        min = heap.extract_min
        expect(min).to be_nil
        expect(heap.heap).to eq([])
      end
    end
  end
end