class Map
  attr_reader :hash

  def initialize
    @hash = []
  end

  def assign(key, value)
    if !lookup(key)
      @hash << [key, value]
    else
      remove(key)
      @hash << [key, value]
    end 
    [key, value]
  end

  def lookup(key)
    @hash.each do |arr|
      return arr[1] if arr[0] == key
    end
    false
  end

  def remove(key)
    @hash.reject! { |arr| arr[0] == key}
    false
  end

  def show
    deep_dup(@hash)
  end

  def deep_dup(arr)
    arr.map { |el| el.is_a?(Array) ? deep_dup(el) : el}
  end
end


p hash = Map.new
p hash.assign("a",1)
p hash.show
p hash.assign("b",2)
p hash.assign("c",3)
p hash.show
p hash.remove("c")
p hash.lookup("b")
p hash.assign("b",4)
p hash.show
