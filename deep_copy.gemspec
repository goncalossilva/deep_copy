# coding: UTF-8

Gem::Specification.new do |s|
  s.name              = "deep_copy"
  s.version           = "0.0.2"
  s.platform          = Gem::Platform::RUBY
  s.authors           = ["Gonçalo Silva", "Jan De Poorter"]
  s.email             = ["goncalossilva@gmail.com", "github@defv.be"]
  s.homepage          = "http://github.com/goncalossilva/deep_copy"
  s.summary           = "Deep copy for Active Record objects"
  s.description       = "A method to deep copy AR objects, including their associations"
  s.rubyforge_project = s.name

  s.required_rubygems_version = ">= 1.3.7"
  
  # If you have other dependencies, add them here
  s.add_dependency "activerecord", ">= 2.3"

  # If you need to check in files that aren't .rb files, add them here
  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.extensions    = `git ls-files ext/extconf.rb`.split("\n")
  
  s.require_path = 'lib'

  # For C extensions
  # s.extensions = "ext/extconf.rb"
end
