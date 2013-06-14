#!/usr/bin/env ruby
# encoding: UTF-8

require 'benchmark'
require 'socket'
n = 10000

Benchmark.bm(7, ">hostanem:", ">uname:", ">gethostname") do |x|
  a = x.report("hostanem   ") {  n.times{ `hostname`.chomp } }
  b = x.report("uname      ") {  n.times{ `uname -n`.chomp } }
  c = x.report("gethostname") {  n.times{ Socket.gethostname } }
end


