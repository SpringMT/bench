#!/usr/bin/env ruby
# encoding: UTF-8

require 'benchmark'
n = 1000000
array = []
Benchmark.bm(7, ">total:", ">ave:") do |x|
  a = x.report("push") { n.times{ array.push 1 } }
  b = x.report("<<") { n.times{ array << 1 } }
end

=begin
% ruby array_push_vs_arrows.rb                                                            ~/bench/r              user     system      total        real
push      0.160000   0.010000   0.170000 (  0.169633)
<<        0.120000   0.000000   0.120000 (  0.126805)
=end
