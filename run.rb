#!/usr/bin/env ruby

TOTAL_USERS = 1000
TOTAL_POSTS = 10
TOTAL_VOTES = TOTAL_USERS * TOTAL_POSTS

require 'rubygems'
require 'benchmark'
require 'bundler'
Bundler.setup

solution_name = ARGV.first
SKIP_ADDITIONAL_INDEXES = ARGV[1] == 'skip_additional_indexes'

load File.expand_path(File.dirname(__FILE__) + "/solutions/#{solution_name}/init.rb")  
solution = "#{solution_name}_solution".classify.constantize

puts "\n#{solution}: creating database ..."
Benchmark.bm do |bm|
  bm.report { solution.create_database }
end

puts "\n#{solution}: initializing data ..."
Benchmark.bm do |bm|
  bm.report { solution.init_data }
end

puts "\n#{solution}: creating #{TOTAL_VOTES} votes ..."
Benchmark.bm do |bm|
  bm.report { solution.create_votes }
end

puts "\n#{solution}: creating #{TOTAL_VOTES} duplicate votes ..."
Benchmark.bm do |bm|
  bm.report { solution.create_votes }
end

puts "\n#{solution}: unvoting #{TOTAL_VOTES} votes ..."
Benchmark.bm do |bm|
  bm.report { solution.unvote_votes }
end

puts "\n#{solution}: unvoting #{TOTAL_VOTES} votes when they havent voted..."
Benchmark.bm do |bm|
  bm.report { solution.unvote_votes }
end

