require 'uglifier'
require 'digest/md5'

class Squeezy

  java_import Java::com.yahoo.platform.yui.compressor.JavaScriptCompressor
  java_import Java::com.yahoo.platform.yui.compressor.CssCompressor

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

  def compress_js(contents, engine = 'yui')
    with_cached_file "/tmp/#{Digest::MD5.hexdigest(contents)}.js" do
      reporter = Reporter.new
      begin
        case engine
        when 'yui'
          JavaScriptCompressor.new(java.io.StringReader.new(contents), reporter).compress(result = java.io.StringWriter.new(), 0, true, false, false, false)
          result.to_s
        when 'uglifyjs'
          Uglifier.new(compress: {keep_fargs: true}).compile(contents)
        else
          raise "unknown engine `#{engine}'"
        end
      rescue => e
        raise "Compression error: #{e.message} #{reporter.to_s}"
      end
    end
  end
end