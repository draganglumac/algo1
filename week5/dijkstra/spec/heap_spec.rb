$: << '.'
$: << '..'

require 'rspec'
require 'dijkstra_heap'

describe DijkstraHeap do
  let(:heap) { DijkstraHeap.new { |a, b| a <=> b } }

  describe 'insert' do
    it 'should insert first element into root position' do
      heap.insert [3, 0]
      expect(heap.heap.first).to eq([3, 0])
      expect(heap.heap.size).to eq(1)
      expect(heap.priority[0]).to eq(0)
    end

    describe 'empty heap' do
      it 'should be empty intially' do
        expect(heap.empty?).to be_truthy
      end
    end

    describe 'non empty heap' do
      before(:each) do
        heap.insert [3, 0]
        heap.insert [5, 1]
        heap.insert [1, 2]
        heap.insert [2, 3]
        heap.insert [10, 4]
        heap.insert [7, 5]
      end

      it 'should insert elements so that heap property is preserved' do
        expect(heap.heap).to eq([[1, 2], [2, 3], [3, 0], [5, 1], [10, 4], [7, 5]])
      end

      it 'should decrease key' do
        heap.decrease_key(6, 15)
        expect(heap.heap).to eq([[1, 2], [2, 3], [3, 0], [5, 1], [10, 4], [7, 5]])

        heap.decrease_key(2, 0)
        expect(heap.heap).to eq([[0, 2], [2, 3], [3, 0], [5, 1], [10, 4], [7, 5]])
        expect(heap.priority[2]).to eq(0)

        heap.decrease_key(4, 1)
        expect(heap.heap).to eq([[0, 2], [1, 4], [3, 0], [5, 1], [2, 3], [7, 5]])
        expect(heap.priority[4]).to eq(1)
      end

      it 'should extract minimum' do
        min = heap.extract_min
        expect(min).to eq([1, 2])
        expect(heap.priority[2]).to be_nil
        expect(heap.heap).to eq([[2, 3], [5, 1], [3, 0], [7, 5], [10, 4]])

        min = heap.extract_min
        expect(min).to eq([2, 3])
        expect(heap.priority[3]).to be_nil
        expect(heap.heap).to eq([[3, 0], [5, 1], [10, 4], [7, 5]])

        min = heap.extract_min
        expect(min).to eq([3, 0])
        expect(heap.priority[0]).to be_nil
        expect(heap.heap).to eq([[5, 1], [7, 5], [10, 4]])

        min = heap.extract_min
        expect(min).to eq([5, 1])
        expect(heap.priority[1]).to be_nil
        expect(heap.heap).to eq([[7, 5], [10, 4]])

        min = heap.extract_min
        expect(min).to eq([7, 5])
        expect(heap.priority[5]).to be_nil
        expect(heap.heap).to eq([[10, 4]])

        min = heap.extract_min
        expect(min).to eq([10, 4])
        expect(heap.priority[4]).to be_nil
        expect(heap.empty?).to be_truthy

        min = heap.extract_min
        expect(min).to be_nil
        expect(heap.heap).to eq([])
      end
    end
  end
end