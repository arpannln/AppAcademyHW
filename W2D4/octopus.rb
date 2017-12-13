def sluggishOct(arr)
  sorted = false 
  until sorted 
    sorted = true 
    (0...arr.length-1).each do |idx1| 
      (0..arr.length-1).each do |idx2| 
        if arr[idx1].length < arr[idx2].length 
          sorted = false 
          self[idx1], self[idx2] = self[idx2], self[idx1]
        end 
      end 
    end 
  end 
  arr.last 
end 

class Array
  #this should look familiar
  def merge_sort(&prc)
    prc ||= Proc.new { |x, y| x <=> y }

    return self if count <= 1

    midpoint = count / 2
    sorted_left = self.take(midpoint).merge_sort(&prc)
    sorted_right = self.drop(midpoint).merge_sort(&prc)

    Array.merge(sorted_left, sorted_right, &prc)
  end

  private
  def self.merge(left, right, &prc)
    merged = []

    until left.empty? || right.empty?
      if prc.call(left.first, right.first) == -1
        merged << left.shift
      else
        merged << right.shift
      end
    end

    merged + left + right 
  end
end

def dominantOct(arr)
  prc = Proc.new {|x, y| x.length <=> y.length}
  arr.merge_sort(&prc).last 
end 

def cleverOct(arr)
  longest = arr.first 
  arr.each do |el| 
    longest = el if el.length > longest.length 
  end 
  longest 
end 

def slowDance(move, tiles_array)
  tiles_array.each_with_index do |el, idx| 
    return idx if move == el 
  end 
end 

OCTOPUS = { "up" => 0, 
            "right-up" => 1,
            "right" => 2,
            "right-down" => 3,
            "down" => 4,
            "left-down" => 5,
            "left" => 6,
            "left-up" => 7
           }
           
def constantDance(move, OCTOPUS)
  OCTOPUS[move]
end 
