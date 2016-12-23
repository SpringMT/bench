#!/usr/bin/env ruby

require 'benchmark'
n = 1000000

Benchmark.bm(7, '>concat:', '>each:') do |x|
  a = x.report('single') {  n.times{ 'hogehoge' } }
  b = x.report('double') {  n.times{ "hogehoge" } }
end

