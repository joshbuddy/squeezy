require 'spec/rake/spectask'
require 'spec/rake/spectask_precmd'

task :default => :'spec:all'

namespace(:spec) do

  task :all => [:css, :js]

  Spec::Rake::SpecTask.new(:css) do |t|
    t.precmd=%[CLASSPATH=#{(Dir['ext/*.jar'] * ':')}]
    t.spec_opts ||= []
    t.spec_opts << "--options" << "spec/css/spec.opts"
    t.spec_files = FileList['spec/css/*.rb']
  end

  Spec::Rake::SpecTask.new(:js) do |t|
    t.precmd=%[CLASSPATH=#{(Dir['ext/*.jar'] * ':')}]
    t.spec_opts ||= []
    t.spec_opts << "--options" << "spec/js/spec.opts"
    t.spec_files = FileList['spec/js/*.rb']
  end
end

task :cultivate do
  system "touch Manifest.txt; rake check_manifest | grep -v \"(in \" | patch"
  system "rake debug_gem | grep -v \"(in \" > `basename \\`pwd\\``.gemspec"
end