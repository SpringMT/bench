#!/usr/bin/env ruby
# encoding: UTF-8

require 'benchmark'
require 'mysql2'
require 'ap'
require 'parallel'
require 'connection_pool'

CONCURRENCY = 20
TIMEOUT     = 30
COUNTS      = 500

myisam_5_5_pool = ConnectionPool.new(size: CONCURRENCY, timeout: TIMEOUT) {
  Mysql2::Client.new(
    host: "",
    username: "",
    password: "",
    database: "sequence",
  )
}

innodb_5_5_pool = ConnectionPool.new(size: CONCURRENCY, timeout: TIMEOUT) {
  Mysql2::Client.new(
    host: "",
    username: "",
    password: "",
    database: "sequence",
  )
}

myisam_5_6_pool = ConnectionPool.new(size: CONCURRENCY, timeout: TIMEOUT) {
  Mysql2::Client.new(
    host: "",
    username: "",
    password: "",
    database: "sequence",
  )
}

innodb_5_6_pool = ConnectionPool.new(size: CONCURRENCY, timeout: TIMEOUT) {
  Mysql2::Client.new(
    host: "",
    username: "",
    password: "",
    database: "sequence",
  )
}

counts = Array.new(COUNTS, '')

Benchmark.bm(7, ">total:", ">ave:") do |x|
  a = x.report("MySQL 5.5 MyISAM                ") do
    Parallel.each(counts, in_threads: CONCURRENCY) do |y|
      myisam_5_5_pool.with_connection do |conn|
        conn.query('UPDATE seq_myisam SET id=LAST_INSERT_ID(id+1)')
      end
    end
  end

  b = x.report("MySQL 5.5 InnoDB Non Transaction") do
     Parallel.each(counts, in_threads: CONCURRENCY) do |y|
      innodb_5_5_pool.with_connection do |conn|
        conn.query('UPDATE seq_innodb SET id=LAST_INSERT_ID(id+1)')
      end
    end
  end

  c = x.report("MySQL 5.6 MyISAM                ") do
    Parallel.each(counts, in_threads: CONCURRENCY) do |y|
      myisam_5_6_pool.with_connection do |conn|
        conn.query('UPDATE seq_myisam SET id=LAST_INSERT_ID(id+1)')
      end
    end
  end

  d = x.report("MySQL 5.6 InnoDB Non Transaction") do
    Parallel.each(counts, in_threads: CONCURRENCY) do |y|
      innodb_5_6_pool.with_connection do |conn|
        conn.query('UPDATE seq_myisam SET id=LAST_INSERT_ID(id+1)')
      end
    end
  end

end



