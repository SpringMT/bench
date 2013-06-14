#!/usr/bin/env ruby
# encoding: UTF-8

require 'benchmark'
require 'mysql2'
require 'ap'
require 'parallel'
require 'connection_pool'

CONCURRENCY = 20
TIMEOUT     = 30
COUNTS      = 1000

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
  a = x.report("MySQL 5.6 InnoDB Transaction Read Only Indivisualy") do
    Parallel.each(counts, in_threads: CONCURRENCY) do |y|
      innodb_5_6_pool.with_connection do |conn|
        conn.query('SET autocommit = 0')
        conn.query('SET TRANSACTION READ ONLY')
        conn.query('SELECT id FROM seq_innodb')
        conn.query('COMMIT')
      end
    end
  end

  b = x.report("MySQL 5.6 InnoDB Transaction Read Only Total") do
    innodb_5_6_pool.with_connection do |conn|
      conn.query('SET autocommit = 0')
      conn.query('SET TRANSACTION READ ONLY')
    end
    Parallel.each(counts, in_threads: CONCURRENCY) do |y|
      innodb_5_6_pool.with_connection do |conn|
        conn.query('SELECT id FROM seq_innodb')
      end
    end
    innodb_5_6_pool.with_connection do |conn|
      conn.query('COMMIT')
    end
  end

  c = x.report("MySQL 5.6 InnoDB Non Transaction") do
    Parallel.each(counts, in_threads: CONCURRENCY) do |y|
      innodb_5_6_pool.with_connection do |conn|
        conn.query('SELECT id FROM seq_innodb')
      end
    end
  end

end



