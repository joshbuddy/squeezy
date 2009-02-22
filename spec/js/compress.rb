require 'java'
require 'lib/squeezy/reporter'
require 'lib/squeezy/compressor'

describe "A JS Compressor" do
  it "should return less than it started with" do
    js = IO.read("spec/fixtures/js-multiline.js")
    js.size.should > compress_js(js).size
  end

  it "should have no new lines" do
    js = IO.read("spec/fixtures/js-multiline.js")
    compress_js(js).count("\n").should == 0
  end

  it "should return the original file when the js is malformed" do
    js_malformed = IO.read("spec/fixtures/js-malformed.js")
    compress_js(js_malformed).should == js_malformed
  end
end