# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sploder/version'
require 'aws-sdk'

Gem::Specification.new do |gem|
  gem.name          = "sploder"
  gem.version       = Sploder::VERSION
  gem.authors       = ["Bill Patrianakos"]
  gem.email         = ["bill@billpatrianakos.me"]
  gem.description   = 'Sploder is the S3 uploader'
  gem.summary       = 'Easily upload files to S3, create buckets, set ACL, and more'
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
