# coding: UTF-8

Gem::Specification.new do |s|
  s.name              = "deep_clone"
  s.version           = "0.0.1"
  s.platform          = Gem::Platform::RUBY
  s.authors           = ["Gonçalo Silva", "Jan De Poorter"]
  s.email             = ["goncalossilva@gmail.com", "github@defv.be"]
  s.homepage          = "http://github.com/goncalossilva/deep_clone"
  s.summary           = "Deep clone for Active Record"
  s.description       = "A method to deep clone AR objects, including its associations"
  s.rubyforge_project = s.name

  s.required_rubygems_version = ">= 1.3.7"
  
  # If you have other dependencies, add them here
  s.add_dependency "active_record", ">= 2.3"

  # If you need to check in files that aren't .rb files, add them here
  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.extensions    = `git ls-files ext/extconf.rb`.split("\n")
  
  s.require_path = 'lib'

  # For C extensions
  # s.extensions = "ext/extconf.rb"
end
