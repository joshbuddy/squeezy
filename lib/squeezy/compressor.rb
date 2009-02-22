include_class('com.yahoo.platform.yui.compressor.JavaScriptCompressor')
include_class('com.yahoo.platform.yui.compressor.CssCompressor')

def compress_css(css_contents)
  contents = css_contents.dup
  contents.gsub!(/(["'])(.*?)(\.jpg|\.png|\.gif)\1/) do |m|
    mtime = File.exists?(File.join($config['rails_path'], "#{$~[2]}#{$~[3]}")) && File.mtime(File.join($config['rails_path'], "#{$~[2]}#{$~[3]}"))
    "#{$~[1]}#{$~[2]}#{$~[3]}?#{mtime.to_i}#{$~[1]}"
  end
  CssCompressor.new(java.io.StringReader.new(contents)).compress(result = java.io.StringWriter.new(), -1)
  result.to_s
rescue Exception => e
  $stderr.puts e
  css_contents
end

def compress_js(js_contents)
  contents = js_contents.dup
  contents.each {|line| line.gsub!(/console\..*?[;\n]/,'') }
  JavaScriptCompressor.new(java.io.StringReader.new(contents), Reporter.new).compress(result = java.io.StringWriter.new(), -1, false, false, false, false)
  result.to_s
rescue Exception => e
  $stderr.puts e
  js_contents
end
