#!/usr/bin/env ruby
# encoding: UTF-8

require 'benchmark'
n = 1000000
array = []
Benchmark.bm(7, ">total:", ">ave:") do |x|
  a = x.report("push") { n.times{ array.push 1 } }
  b = x.report("<<") { n.times{ array << 1 } }
end


