require 'spec/rake/spectask'

require 'bundler'
Bundler::GemHelper.install_tasks

Spec::Rake::SpecTask.new do |t|
  t.spec_opts ||= []
  t.spec_opts << "--options" << "spec/spec.opts"
  t.spec_files = FileList['spec/**/*_spec.rb']
end
