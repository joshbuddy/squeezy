require 'digest/md5'

class Squeezy

  include_class Java::com.yahoo.platform.yui.compressor.JavaScriptCompressor
  include_class Java::com.yahoo.platform.yui.compressor.CssCompressor

  def with_cached_file(file)
    if File.exist?(file)
      File.read(file)
    else
      contents = yield
      File.open(file, 'w') {|f| f << contents}
      contents
    end
  end

  def compress_css(contents)
    with_cached_file "/tmp/#{Digest::MD5.hexdigest(contents)}.css" do
      CssCompressor.new(java.io.StringReader.new(contents)).compress(result = java.io.StringWriter.new(), -1)
      result.to_s
    end
  rescue Exception => e
    $stderr.puts e
    $stderr.puts "Compression of CSS failed!"
    contents
  end

  def compress_js(contents)
    with_cached_file "/tmp/#{Digest::MD5.hexdigest(contents)}.js" do
      JavaScriptCompressor.new(java.io.StringReader.new(contents), Reporter.new).compress(result = java.io.StringWriter.new(), -1, true, false, false, false)
      result.to_s
    end
  rescue Exception => e
    $stderr.puts e
    $stderr.puts "Compression of JS failed!"
    contents
  end
end