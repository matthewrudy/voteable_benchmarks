class Post < ActiveRecord::Base
  class << self
    def vote(user_id, post_id, value)
      # create a vote if one doesnt already exist
      if connection.insert("INSERT IGNORE INTO votes SET user_id=#{user_id}, post_id=#{post_id}, value=#{Vote.connection.quote(value)}")
        point_difference = value ? "+1" : "-2"
        direction_counter = value ? "up_votes_count" : "down_votes_count"

        connection.update "UPDATE posts, votes SET votes_count=votes_count+1, votes_point=votes_point#{point_difference}, #{direction_counter}=#{direction_counter}+1 WHERE posts.id=#{post_id}"
      end
    end
  
    def unvote(user_id, post_id)
      # create a vote if one doesnt already exist
      if vote = Vote.find_by_post_id_and_user_id(post_id, user_id)
        vote.destroy
        point_difference = value ? "-1" : "+2"
        direction_counter = value ? "up_votes_count" : "down_votes_count"
        
        connection.update "UPDATE posts, votes SET votes_count=votes_count-1, votes_point=votes_point#{point_difference}, #{direction_counter}=#{direction_counter}-1 WHERE posts.id=#{post_id}"
      end
    end
  end
  
  has_many :votes
end
