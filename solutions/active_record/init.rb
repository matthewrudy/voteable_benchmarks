require 'active_record'
require 'active_support'
require 'mysql2'

require File.expand_path(File.dirname(__FILE__) + '/../shared/abstract_solution')
require File.expand_path(File.dirname(__FILE__) + '/../shared/voteable')
require File.expand_path(File.dirname(__FILE__) + '/models/user')
require File.expand_path(File.dirname(__FILE__) + '/models/post')
require File.expand_path(File.dirname(__FILE__) + '/models/vote')


module ActiveRecordSolution
  extend AbstractSolution
  
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
  
  def self.vote(user_id, post_id, value)
    Post.vote(user_id, post_id, value)
  end
  
  def self.unvote(user_id, post_id, value = nil)
    Post.unvote(user_id, post_id)
  end
end
