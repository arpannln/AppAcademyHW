require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef", name: "arpsss") }
  
  let(:ice_cream) { Dessert.new("ice_cream", 10, chef)}
  
  describe "#initialize" do
    it "sets a type" do
      expect(ice_cream.type).to eq("ice_cream")
    end 

    it "sets a quantity" do 
      expect(ice_cream.quantity).to eq(10)
    end 
    
    it "starts ingredients as an empty array" do 
      expect(ice_cream.ingredients).to eq([])
    end 
    
    it "raises an argument error when given a non-integer quantity" do
      expect{Dessert.new("cotton-candy", "notAnInteger", chef) }.to raise_error(ArgumentError)
    end 
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do 
      ice_cream.add_ingredient("pistachio")
      expect(ice_cream.ingredients).to eq(["pistachio"])
    end 
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do 
      ice_cream.add_ingredient("pistachio")
      ice_cream.add_ingredient("strawberry")
      ice_cream.add_ingredient("chocolate")
      ice_cream.add_ingredient("vanilla")
      ice_cream.add_ingredient("HAHA")
      
      expect(ice_cream.ingredients).to eq(["pistachio", "strawberry", "chocolate", "vanilla", "HAHA"])
      ice_cream.mix!
      expect(ice_cream.ingredients).to_not eq(["pistachio", "strawberry", "chocolate", "vanilla", "HAHA"])
      
    end 
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do 
      ice_cream.eat(5)
      expect(ice_cream.quantity).to eq(5)
    end 
    it "raises an error if the amount is greater than the quantity" do 
      expect{ice_cream.eat(100)}.to raise_error("not enough left!")
    end 
    
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do 
      allow(chef).to receive(:titleize).and_return("Chef Arpsss the Great Baker")
      expect(ice_cream.serve).to eq("Chef Arpsss the Great Baker has made 10 ice_creams!")
    end 
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do 
      expect(chef).to receive(:bake).with(ice_cream)
      ice_cream.make_more 
    end 
    
  end
end
