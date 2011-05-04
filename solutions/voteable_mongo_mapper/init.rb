require 'mongo_mapper'
require 'voteable_mongo'

# Must init MongoMapper database before include models
MongoMapper.database = 'voteable_benchmarks'
MongoMapper.connection.drop_database('voteable_benchmarks')

require File.expand_path(File.dirname(__FILE__) + '/../shared/abstract_solution')
require File.expand_path(File.dirname(__FILE__) + '/models/user')
require File.expand_path(File.dirname(__FILE__) + '/models/post')

module VoteableMongoMapperSolution
  extend AbstractSolution  
  
  def self.create_database
    # Do nothing
  end
  
  def self.vote(user_id, post_id, happy)
    Post.vote(
      :voter_id => user_id,
      :votee_id => post_id,
      :value => happy ? :up : :down
    )
  end

  def self.unvote(user_id, post_id, happy)
    Post.vote(
      :voter_id => user_id,
      :votee_id => post_id,
      :value => happy ? :up : :down,
      :unvote => true
    )
  end
end
