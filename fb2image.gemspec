# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fb2image/version'

Gem::Specification.new do |spec|
  spec.name          = "fb2image"
  spec.version       = FB2Image::VERSION
  spec.authors       = ["Kazuhiro Yamada"]
  spec.email         = ["yamadakazu45@gmail.com"]
  spec.description   = %q{Convert Frame Buffer to Image}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/k-yamada/fb2image"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
end
