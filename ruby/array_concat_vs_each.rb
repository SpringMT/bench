#!/usr/bin/env ruby
# encoding: UTF-8

require 'benchmark'
n = 1000000
content = []
added   = [4,5,6]

Benchmark.bm(7, ">concat:", ">each:") do |x|
  a = x.report("concat") {  n.times{ content.concat added } }
  b = x.report("each") {  n.times{ added.each {|i| content << i} } }
end


