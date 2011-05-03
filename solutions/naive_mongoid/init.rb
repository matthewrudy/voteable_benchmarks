# Equivalent to ActiveRecordSolution
require 'mongoid'

require File.expand_path(File.dirname(__FILE__) + '/../shared/abstract_solution')
require File.expand_path(File.dirname(__FILE__) + '/../shared/voteable')
require File.expand_path(File.dirname(__FILE__) + '/models/user')
require File.expand_path(File.dirname(__FILE__) + '/models/post')
require File.expand_path(File.dirname(__FILE__) + '/models/vote')

module NaiveMongoidSolution
  extend AbstractSolution  

  def self.create_database
    Mongoid.configure do |config|
      name = 'voteable_benchmarks'
      host = 'localhost'
      config.master = Mongo::Connection.new.db(name)
      config.autocreate_indexes = true
      config.logger = nil
    end

    Mongoid::database.connection.drop_database(Mongoid::database.name)
  end
  
  def self.vote(user_id, post_id, value)
    Post.vote(user_id, post_id, value)
  end

  def self.unvote(user_id, post_id, value = nil)
    Post.unvote(user_id, post_id)
  end
end
