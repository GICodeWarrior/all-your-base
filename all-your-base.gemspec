# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{all-your-base}
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rusty Burchfield"]
  s.date = %q{2009-10-19}
  s.description = %q{Provides numeric base conversions greater than base 36}
  s.email = %q{GICodeWarrior@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "AllYourBaseAnimated.gif",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "all-your-base.gemspec",
     "lib/all_your_base.rb",
     "lib/all_your_base/are.rb",
     "lib/all_your_base/are/belong_to_us.rb",
     "scripts/brute.rb",
     "scripts/demo.rb",
     "spec/all_your_base/are/belong_to_us_spec.rb",
     "spec/all_your_base/are_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/GICodeWarrior/all-your-base}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Numeric base conversions greater than base 36}
  s.test_files = [
    "spec/spec_helper.rb",
     "spec/all_your_base/are/belong_to_us_spec.rb",
     "spec/all_your_base/are_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
