class Post < ActiveRecord::Base
  class << self
    def vote(user_id, post_id, value)
      # create a vote if one doesnt already exist
      connection.execute "INSERT IGNORE INTO votes SET user_id=#{user_id}, post_id=#{post_id}, value=#{Vote.connection.quote(value)}"
    
      reset_vote_counts(post_id)
    end
  
    def reset_vote_counts(post_id)
      # set the vote counts by summing over existing votes
      connection.execute "UPDATE posts, votes SET votes_count=COUNT(votes.id), votes_point=SUM(IF(votes.value, 1, -2)), up_votes_count=SUM(IF(votes.value,1,0)), down_votes_count=SUM(IF(votes.value,0,1)) WHERE posts.id=#{post_id} && votes.post_id = posts.id"
    end
  
    def unvote(user_id, post_id)
      # create a vote if one doesnt already exist
      if Vote.delete_all("post_id = #{post_id} AND user_id=#{user_id}") > 0
        reset_vote_counts(post_id)
      end
    end
  end
  
  has_many :votes
end
