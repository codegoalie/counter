require "Hasher.rb"

describe Hasher do
  describe "encode ints to hashes" do
    it "should return a single char for ints < 62" do
      Hasher::encode(13).should == "d"
    end

    it "should return multiple chars for ints > 62" do
      Hasher::encode(14652).should == "3Ok"
    end
  end

  describe "decode hashes to ints" do
    it "should decode a single char hash to a number < 62" do
      Hasher::decode("d").should == 13
    end

    it "should return an int > 62 for hashes more than one char" do
      Hasher::decode("3Ok").should == 14652
    end
  end
end
