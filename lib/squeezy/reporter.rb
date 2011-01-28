class Squeezy
  class Reporter

    include_class Java::org.mozilla.javascript.EvaluatorException
    include_class Java::org.mozilla.javascript.ErrorReporter

    def initialize
      @errors = StringIO.new
    end

    def to_s
      @errors.rewind
      @errors.read
    end

    def do_message(type, message, source_name, line, line_source, line_offset)
      @errors.puts(line < 0 ? "\n[#{type.to_s.upcase}] #{message} --> #{line_source}" : "\n[#{type.to_s.upcase}] #{line} #{line_offset} : #{message} --> #{line_source}")
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
end