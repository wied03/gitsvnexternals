require 'psych'
require 'rake'
require 'rubygems'
require 'rubygems/package_task'
require 'rspec/core/rake_task'
require './lib/version'
require './lib/tools'

task :ci => :spec

with("spec") do |testdir|
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = FileList["#{testdir}/**/*_spec.rb"] 
  end

  task :clean_install => [:repackage, :install]

  with("gitsvnexternals") do |gemname|
    task :install do
      sh "gem install #{FileList['pkg/*.gem'].first()}"
      sh "gem cleanup #{gemname}"
    end

    with ("lib") do |src|
      spec = Gem::Specification.new do |s|
        s.name = gemname
        s.files = FileList["#{src}/**/*.rb",
                           "#{testdir}/**/*.rb"]
        s.test_files = FileList["#{testdir}/**/*.rb"]
        s.version = BW::Version.incrementandretrieve
        s.summary = "Adds SVN externals support for GIT SVN"
        s.description = s.summary
        s.author = "Brady Wied"
        s.email = "brady@wied.us"
      end

      Gem::PackageTask.new(spec) do |pkg|
      end
    end
  end
end