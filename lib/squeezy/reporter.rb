include_class('org.mozilla.javascript.EvaluatorException')

class Reporter
  include_class 'org.mozilla.javascript.ErrorReporter'

  def do_message(type, message, source_name, line, line_source, line_offset)
    if (line < 0)
      $stderr.puts("\n[#{type.to_s.upcase}] #{message} --> #{line_source}")
    else
      $stderr.puts("\n[#{type.to_s.upcase}] #{line} #{line_offset} : #{message} --> #{line_source}")
    end
  end

  def warning(message, source_name, live, line_source, line_offset)
    do_message(:warning, message, source_name, live, line_source, line_offset)
  end

  def error(message, source_name, live, line_source, line_offset)
    do_message(:error, message, source_name, live, line_source, line_offset)
  end

  def runtimeError(message, source_name, line, line_source, line_offset)
    error(message, source_name, line, line_source, line_offset)
    EvaluatorException.new(message)
  end
end
