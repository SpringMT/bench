#!/usr/bin/env ruby
# encoding: UTF-8

require 'benchmark'
n = 1000000
Benchmark.bm(7, ">total:", ">ave:") do |x|
  a = x.report("string:") { n.times{ hash = {"aaa" => 123} } }
  b = x.report("string_freez:") { n.times{ hash = {"aaa".freeze => 123} } }
  c = x.report("symbol:") { n.times{ hash = {aaa: 123} }     }
end


=begin
% ruby string_vs_string_freez_vs_symbol_in_hash.rb                                        ~/bench/r              user     system      total        real
string:   0.940000   0.020000   0.960000 (  0.971731)
string_freez:  0.880000   0.030000   0.910000 (  0.919527)
symbol:   0.740000   0.040000   0.780000 (  0.793753)
=end
