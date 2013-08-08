require 'rubygems'
require 'bundler/setup'
require 'pp'

require 'fb2image' # and any other gems you need

RSpec.configure do |config|
  `mkdir -p tmp`
  # some (optional) config here
end
