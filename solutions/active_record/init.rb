require 'active_record'
require 'active_support'
require 'mysql2'

require File.expand_path(File.dirname(__FILE__) + '/../shared/voteable')
require File.expand_path(File.dirname(__FILE__) + '/models/user')
require File.expand_path(File.dirname(__FILE__) + '/models/post')
require File.expand_path(File.dirname(__FILE__) + '/models/vote')


module ActiveRecordSolution
  def self.create_database
    puts 'MySQL database'

    config = {
      'adapter' => 'mysql2',
      'encoding' => 'utf8',
      'host' => 'localhost',
      'username' => 'root',
      'database' => 'voteable_benchmarks',
    }

    ActiveRecord::Base.establish_connection(config)
    begin ActiveRecord::Base.connection.drop_database(config['database']); rescue; end

    ActiveRecord::Base.establish_connection(config.merge('database' => nil))
    ActiveRecord::Base.connection.create_database(config['database'], :charset => 'utf8', :collation => 'utf8_unicode_ci')
    ActiveRecord::Base.establish_connection(config)

    load File.expand_path(File.dirname(__FILE__) + '/schema.rb')
  end
  
  def self.init_data
    load File.expand_path(File.dirname(__FILE__) + '/../shared/seeds.rb')
    @user_ids = User.all.map(&:id)
    @post_ids = Post.all.map(&:id)
  end
  
  def self.create_votes
    @user_ids.each do |user_id|
      @post_ids.each do |post_id|
        Post.vote(user_id, post_id, true)
      end
    end
  end

  def self.unvote_votes
    @user_ids.each do |user_id|
      @post_ids.each do |post_id|
        Post.unvote(user_id, post_id)
      end
    end
  end
end
