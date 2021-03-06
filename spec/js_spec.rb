require 'spec_helper'

describe "A JS Compressor" do
  before(:each) do
    @squeezy = Squeezy.new
    `rm -rf /tmp/*.css`
    `rm -rf /tmp/*.js`
  end

  it "should return less than it started with" do
    js = IO.read("spec/fixtures/js-multiline.js")
    @squeezy.compress_js(js).should == "function blah(b,a){return b==\"asd\\nasdasd\"\n};"
  end

  it "should return less than it started with when using uglify" do
    js = IO.read("spec/fixtures/js-multiline.js")
    @squeezy.compress_js(js, 'uglifyjs').should == "function blah(a,n){return\"asd\\nasdasd\"==a}"
  end

  it "should have one newline" do
    js = IO.read("spec/fixtures/js-multiline.js")
    @squeezy.compress_js(js).count("\n").should == 1
  end

  it "should raise an error when original file when the js is malformed" do
    js_malformed = IO.read("spec/fixtures/js-malformed.js")
    proc{@squeezy.compress_js(js_malformed)}.should raise_error
  end
end