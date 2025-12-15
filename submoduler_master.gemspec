# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name = 'submoduler_master'
  spec.version = '0.1.0'
  spec.authors = ['Your Name']
  spec.email = ['your.email@example.com']

  spec.summary = 'Master submoduler gem for managing submodule dependencies'
  spec.description = 'A Ruby gem that provides master functionality for submoduler with parent and child dependencies'
  spec.homepage = 'https://github.com/magenticmarketactualskill/submoduler-master'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Dependencies on the parent and child gems
  spec.add_dependency 'submoduler-submoduler_parent', '~> 0.2'
  spec.add_dependency 'submoduler-submoduler_child', '~> 0.2'

  # Development dependencies
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rubocop', '~> 1.21'
end