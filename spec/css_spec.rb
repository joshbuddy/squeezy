require 'spec_helper'

describe "A CSS Compressor" do
  before(:each) do
    @squeezy = Squeezy.new
    `rm -rf /tmp/*.css`
    `rm -rf /tmp/*.js`
    @source = File.read("spec/fixtures/css-multiline.css")
  end
  
  it "should return less than it started with" do
    @source.size.should > @squeezy.compress_css(@source).size
  end
  it "should have no new lines" do
    @squeezy.compress_css(@source).count("\n").should == 0
  end
end