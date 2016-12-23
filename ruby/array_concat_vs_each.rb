#!/usr/bin/env ruby

#require 'ruby-prof'
require 'benchmark'
n = 1000000
content = []
added   = [4,5,6]

#RubyProf.start
#stats = AllocationStats.trace do

Benchmark.bm(7, ">concat:", ">each:") do |x|
  a = x.report("concat") {  n.times{ content.concat added } }
  b = x.report("each") {  n.times{ added.each {|i| content << i} } }
end

#end

#puts stats.allocations(alias_paths: true).to_text
#results = stats.allocations.group_by(:@sourcefile, :class).to_a

#result = RubyProf.stop
#printer = RubyProf::FlatPrinter.new(result)
#printer.print(STDOUT)

