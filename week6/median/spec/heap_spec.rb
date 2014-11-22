$: << '.'
$: << '..'

require 'rspec'
require 'heap'

describe Heap do

  describe 'MinHeap' do
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

        it 'should extract minimum' do
          expect(heap.top).to eq(1)
          min = heap.extract_top
          expect(min).to eq(1)
          expect(heap.heap).to eq([2, 5, 3, 7, 10])

          min = heap.extract_top
          expect(min).to eq(2)
          expect(heap.heap).to eq([3, 5, 10, 7])

          min = heap.extract_top
          expect(min).to eq(3)
          expect(heap.heap).to eq([5, 7, 10])

          min = heap.extract_top
          expect(min).to eq(5)
          expect(heap.heap).to eq([7, 10])

          min = heap.extract_top
          expect(min).to eq(7)
          expect(heap.heap).to eq([10])

          expect(heap.top).to eq(10)
          min = heap.extract_top
          expect(min).to eq(10)
          expect(heap.empty?).to be_truthy

          min = heap.extract_top
          expect(min).to be_nil
          expect(heap.heap).to eq([])
        end
      end
    end
  end

  describe 'MaxHeap' do
    let(:heap) { Heap.new { |a, b| b <=> a } }

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
          expect(heap.heap).to eq([10, 5, 7, 2, 3, 1])
        end

        it 'should extract minimum' do
          expect(heap.top).to eq(10)
          min = heap.extract_top
          expect(min).to eq(10)
          expect(heap.heap).to eq([7, 5, 1, 2, 3])

          min = heap.extract_top
          expect(min).to eq(7)
          expect(heap.heap).to eq([5, 3, 1, 2])

          min = heap.extract_top
          expect(min).to eq(5)
          expect(heap.heap).to eq([3, 2, 1])

          min = heap.extract_top
          expect(min).to eq(3)
          expect(heap.heap).to eq([2, 1])

          min = heap.extract_top
          expect(min).to eq(2)
          expect(heap.heap).to eq([1])

          expect(heap.top).to eq(1)
          min = heap.extract_top
          expect(min).to eq(1)
          expect(heap.empty?).to be_truthy

          min = heap.extract_top
          expect(min).to be_nil
          expect(heap.heap).to eq([])
        end
      end
    end
  end

end