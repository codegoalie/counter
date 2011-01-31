require 'counter.rb'

describe Counter do
  describe "ticks" do
    before do
      @current_val = 0
      @params = { :current_value => @current_val }
    end

    it "should increment if ticking up" do
      @params[:incrementing] = true
      counter = Counter.new(@params)
      counter.tick
      counter.current_value.should == @current_val + 1
    end

    it "should dencrement if ticking down" do
      @params[:incrementing] = false
      counter = Counter.new(@params)
      counter.tick
      counter.current_value.should == @current_val - 1
    end
  end
end



