require 'mongoid'
require 'voteable_mongo'

require File.expand_path(File.dirname(__FILE__) + '/../shared/abstract_solution')
require File.expand_path(File.dirname(__FILE__) + '/models/user')
require File.expand_path(File.dirname(__FILE__) + '/models/post')

module VoteableMongoidSolution
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
  
  def self.vote(user_id, post_id, happy)
    Post.vote(
      :voter_id => user_id,
      :votee_id => post_id,
      :value => happy ? :up : :down,
      :return_votee => true
    )
  end

  def self.unvote(user_id, post_id, happy)
    Post.vote(
      :voter_id => user_id, 
      :votee_id => post_id, 
      :value => happy ? :up : :down,
      :unvote => true,
      :return_votee => true
    )
  end
end
