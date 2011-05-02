require 'mongoid'
require 'voteable_mongoid'

require File.expand_path(File.dirname(__FILE__) + '/models/user')
require File.expand_path(File.dirname(__FILE__) + '/models/post')

module VoteableMongoidSolution
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
  
  def self.init_data
    load File.expand_path(File.dirname(__FILE__) + '/../seeds.rb')
    @user_ids = User.all.map(&:id)
    @post_ids = Post.all.map(&:id)
  end
  
  def self.create_votes
    @user_ids.each do |user_id|
      @post_ids.each do |post_id|
        Post.vote(:voter_id => user_id, :votee_id => post_id, :value => :up, :return_votee => true)
      end
    end
  end

  def self.unvote_votes
    @user_ids.each do |user_id|
      @post_ids.each do |post_id|
        Post.vote(:voter_id => user_id, :votee_id => post_id, :value => :up, :unvote => true)
      end
    end
  end
end
