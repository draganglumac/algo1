class Stack
  def initialize
    @stack = []
  end

  def push(e)
    @stack << e
  end

  def pop
    @stack.delete_at(@stack.size - 1)
  end

  def top
    @stack[@stack.size - 1]
  end

  def empty?
    @stack.empty?
  end
end
