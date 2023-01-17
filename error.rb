require 'bundler/setup'
require 'erbse'

@c = 2
template = File.read('block04_ra.erb')
e=Erbse::Engine.new.call(template)
puts eval(e)
