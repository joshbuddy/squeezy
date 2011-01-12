require 'spec_helper'

describe "A JS Compressor" do
  before(:each) do
    @squeezy = Squeezy.new
    `rm -rf /tmp/*.css`
    `rm -rf /tmp/*.js`
  end
  
  it "should return less than it started with" do
    js = IO.read("spec/fixtures/js-multiline.js")
    js.size.should > @squeezy.compress_js(js).size
  end

  it "should have no new lines" do
    js = IO.read("spec/fixtures/js-multiline.js")
    @squeezy.compress_js(js).count("\n").should == 0
  end

  it "should return the original file when the js is malformed" do
    js_malformed = IO.read("spec/fixtures/js-malformed.js")
    proc{@squeezy.compress_js(js_malformed)}.should raise_error
  end
end