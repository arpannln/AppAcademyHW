class Stack
  attr_reader :stack

  def initialize
    @stack = []
  end

  def add(el)
    @stack << el
  end

  def remove
    @stack.pop
  end

  def show
    @stack
  end

end

p my_stack = Stack.new
p my_stack.add(5)
p my_stack.add(6)
p my_stack.remove
p my_stack.show
