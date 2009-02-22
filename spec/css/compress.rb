require 'java'
require 'lib/squeezy/reporter'
require 'lib/squeezy/compressor'

describe "A CSS Compressor" do
  source = File.open("spec/fixtures/css-multiline.css").read
  it "should return less than it started with" do
    source.size.should > compress_css(source).size
  end
  it "should have no new lines" do
    compress_css(source).count("\n").should == 0
  end
end