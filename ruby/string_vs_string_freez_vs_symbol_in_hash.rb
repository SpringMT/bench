#!/usr/bin/env ruby
# encoding: UTF-8

require 'benchmark'
n = 1000000
Benchmark.bm(7, ">total:", ">ave:") do |x|
  a = x.report("string:") { n.times{ hash = {"aaa" => 123} } }
  b = x.report("string_freez:") { n.times{ hash = {"aaa".freeze => 123} } }
  c = x.report("symbol:") { n.times{ hash = {aaa: 123} }     }
end


