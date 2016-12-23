#!/usr/bin/env ruby
# encoding: UTF-8

require 'benchmark'
require 'active_support/core_ext'

#hash_array = [{aaa: 123}, {bbb: 123}, {ccc: 123}, {ddd: 123}, {eee: 123}, {fff: 123}, {ggg: 123}, {hhh: 123}, {iii: 123}]
hash_array = [[{aaa: 123}, {bbb: 123}, {ccc: 123}, {ddd: 123}, {eee: 123}, {fff: 123}, {ggg: 123}, {hhh: 123}, {iii: 123}],[{aaa: 123}, {bbb: 123}, {ccc: 123}, {ddd: 123}, {eee: 123}, {fff: 123}, {ggg: 123}, {hhh: 123}, {iii: 123}]]

n = 100000
Benchmark.bm(7, ">total:", ">ave:") do |x|
  e = x.report("Marshal: ") { n.times{ Marshal.load(Marshal.dump(hash_array)) } }
  t = x.report("deep_dup:") { n.times{ hash_array.deep_dup } }
end


