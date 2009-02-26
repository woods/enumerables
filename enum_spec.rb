require 'rubygems'
require 'spec'

require File.dirname(__FILE__) + '/enum'

describe "Color.all" do
  it "should return all valid colors" do
    Color.all.map { |c| c.label }.sort.should == [:dark_green, :sky_blue, :brick_red].sort
  end
end

describe "A valid color" do
  before(:each) do
    @color = Color.new(:brick_red)
  end
    
  it "should be valid" do
    @color.valid?.should be_true
  end

  it "should always return its label as a symbol" do
    Color.new('dark_green').label.should == :dark_green
  end

  describe "to_s" do    
    it "returns the color's english name" do
      "#{@color}".should == "Brick Red"
    end
  end
  
  describe "label" do
    it "should return the color's label" do
      @color.label.should == :brick_red
    end
  end
  
  describe "hash" do
    it "should return the same value for two of the same colors" do
      Color.new(:dark_green).hash == Color.new(:dark_green).hash
    end
    
    it "should not return the same value for two different colors" do
      Color.new(:dark_green).hash != Color.new(:sky_blue).hash
    end
  end
  
  describe "==" do
    it "should return true for two of the same colors" do
      (Color.new(:dark_green) == Color.new(:dark_green)).should be_true
    end
    
    it "should return false for two different colors" do
      (Color.new(:dark_green) == Color.new(:sky_blue)).should be_false
    end
  end

  describe "!=" do
    it "should return false for two of the same colors" do
      (Color.new(:dark_green) != Color.new(:dark_green)).should be_false
    end
    
    it "should return true for two different colors" do
      (Color.new(:dark_green) != Color.new(:sky_blue)).should be_true
    end
  end

end

describe "An invalid color" do
  
  it "should raise an ArgumentError" do
    lambda {
      Color.new(:asdf)
    }.should raise_error(ArgumentError)
  end

end

describe "A flavor" do
  
  it "should accept a valid flavor" do
    lambda {
      Flavor.new(:vanilla)
    }.should_not raise_error(ArgumentError)
  end
  
  it "should not accept a valid color" do
    lambda {
      Flavor.new(:dark_green)
    }.should raise_error(ArgumentError)
  end
  
end