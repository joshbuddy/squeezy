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
  end

  def compress_js(contents)
    with_cached_file "/tmp/#{Digest::MD5.hexdigest(contents)}.js" do
      reporter = Reporter.new
      begin
        JavaScriptCompressor.new(java.io.StringReader.new(contents), reporter).compress(result = java.io.StringWriter.new(), -1, true, false, false, false)
        result.to_s
      rescue
        raise "Compression error: #{reporter.to_s}"
      end
    end
  end
end