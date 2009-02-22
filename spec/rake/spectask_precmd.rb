module Spec
  module Rake
    class SpecTask
      attr_accessor :precmd

      def define # :nodoc:
        spec_script = File.expand_path(@libs.first + '/../bin/spec')

        lib_path = libs.join(File::PATH_SEPARATOR)
        actual_name = Hash === name ? name.keys.first : name
        unless ::Rake.application.last_comment
          desc "Run specs" + (rcov ? " using RCov" : "")
        end
        task name do
          RakeFileUtils.verbose(verbose) do
            unless spec_file_list.empty?
              # ruby [ruby_opts] -Ilib -S rcov [rcov_opts] bin/spec -- examples [spec_opts]
              # or
              # ruby [ruby_opts] -Ilib bin/spec examples [spec_opts]
              cmd_parts = [@precmd, RUBY]
              cmd_parts += ruby_opts
              cmd_parts << %[-I"#{lib_path}"]
              cmd_parts << "-S rcov" if rcov
              cmd_parts << "-w" if warning
              cmd_parts << rcov_option_list
              cmd_parts << %[-o "#{rcov_dir}"] if rcov
              cmd_parts << %["#{spec_script}"]
              cmd_parts << "--" if rcov
              cmd_parts += spec_file_list.collect { |fn| %["#{fn}"] }
              cmd_parts << spec_option_list
              if out
                cmd_parts << %[> "#{out}"]
                STDERR.puts "The Spec::Rake::SpecTask#out attribute is DEPRECATED and will be removed in a future version. Use --format FORMAT:WHERE instead."
              end
              cmd = cmd_parts.join(" ")
              puts cmd if verbose
              unless system(cmd)
                STDERR.puts failure_message if failure_message
                raise("Command #{cmd} failed") if fail_on_error
              end
            end
          end
        end

        if rcov
          desc "Remove rcov products for #{actual_name}"
          task paste("clobber_", actual_name) do
            rm_r rcov_dir rescue nil
          end

          clobber_task = paste("clobber_", actual_name)
          task :clobber => [clobber_task]

          task actual_name => clobber_task
        end
        self
      end

    end
  end
end
