#!/usr/bin/env ruby
# encoding: UTF-8

require 'benchmark'
n = 1000000
Benchmark.bm(7, ">total:", ">ave:") do |x|
  e = x.report("string:") { n.times{ hash = {"aaa" => 123} } }
  t = x.report("symbol:") { n.times{ hash = {aaa: 123} }     }
end


