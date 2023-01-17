require 'bundler/setup'
require 'erbse'

@a = 1
@b = 2
template = File.read('block03_qa.erb')
e=Erbse::Engine.new.call(template)
puts eval(e)
