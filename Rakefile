require 'bundler'
Bundler::GemHelper.install_tasks


begin
  require 'spec/rake/spectask'

  Spec::Rake::SpecTask.new do |t|
    t.spec_opts ||= []
    t.spec_opts << "--options" << "spec/spec.opts"
    t.spec_files = FileList['spec/**/*_spec.rb']
  end
rescue LoadError
  puts "can't load specs"
end