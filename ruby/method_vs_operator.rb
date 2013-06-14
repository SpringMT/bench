#!/usr/bin/env ruby
# encoding: UTF-8

require 'benchmark'
n = 10_000_000
first = 1
second = 2
third = 3
fourth = 4

Benchmark.bm(7, ">operator:", ">method:") do |x|
  a = x.report("operator") {  n.times{ result = first + second * (third - fourth) } }
  b = x.report("method  ") {  n.times{ result = first.+(second.*(third.-(fourth))) } }
end


