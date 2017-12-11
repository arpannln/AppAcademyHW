class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1 
    @name2 = name2 
    @cups = Array.new(14) {Array.new}
    place_stones 
  end

  def place_stones
    @cups.each_index do |idx|
      next if idx == 6 || idx == 13 
      @cups[idx] = [:stone, :stone, :stone, :stone]
    end
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if start_pos < 0 || start_pos > 13
    raise "Invalid starting cup" if cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos]
    @cups[start_pos] = []
    
    idx = start_pos
    until stones.empty?
      idx += 1
      idx = idx % 14
      if idx == 6
        @cups[idx] << stones.pop if current_player_name == @name1
      elsif idx == 13
        @cups[idx] << stones.pop if current_player_name == @name2
      else
        @cups[idx] << stones.pop
      end
    end
    
    render 
    next_turn(idx)
    return :prompt if idx == 6 || idx == 13
    return :switch if @cups[idx] == [:stone]
    idx 
  end

  def next_turn(ending_cup_idx)
    # helper method to determine what #make_move returns
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups.take(6).all? {|cup| cup.empty?} || @cups[7..12].all? {|cup| cup.empty?}
  end
  
  def winner
    return :draw if @cups[6] == @cups[13]
    (@cups[6].length < @cups[13].length) ? @name2 : @name1 
  end
end
