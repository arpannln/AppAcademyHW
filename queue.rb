class Queue
  attr_reader :queue

  def initialize
    @queue = []
  end

  def enqueue(el)
    queue.unshift(el)
  end

  def dequeue
    queue.pop
  end

  def show
    queue
  end

end

p my_queue = Queue.new
p my_queue.enqueue(5)
p my_queue.enqueue(6)
p my_queue.dequeue
p my_queue.show
