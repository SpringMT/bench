#!/usr/bin/env ruby
# encoding: UTF-8

require 'benchmark'
require 'ruby-prof'

n = 1000000
array = []

RubyProf.start
Benchmark.bm(7, ">total:", ">ave:") do |x|
  a = x.report("push") { n.times{ array.push 1 } }
  b = x.report("<<") { n.times{ array << 1 } }
end

result = RubyProf.stop
printer = RubyProf::FlatPrinter.new(result)
printer.print(STDOUT)

