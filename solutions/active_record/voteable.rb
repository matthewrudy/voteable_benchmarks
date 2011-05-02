module Voteable
  extend ::ActiveSupport::Concern
  
  POINT = {
    true => +1,
    false => -2
  }
  
  module ClassMethods
    def vote(user_id, post_id, value)
      # Validate
      not_voted = Vote.where(:user_id => user_id, :post_id => post_id).count == 0
      if not_voted
        # Create a new vote
        Vote.create(
          :user_id => user_id,
          :post_id => post_id,
          :value => value
        )

        # Get post
        post = Post.find(post_id)
        
        # Update post
        post.votes_point += POINT[value]
        post.votes_count += 1
        if value == true
          post.up_votes_count += 1
        else
          post.down_votes_count += 1
        end
        post.save
      end
    end

    def unvote(user_id, post_id)
      # Get current vote
      vote = Vote.where(:user_id => user_id, :post_id => post_id).first

      # Check if voted
      if vote
        # Destroy vote
        vote.destroy

        # Get post
        post = Post.find(post_id)

        # Update post
        post.votes_point -= POINT[vote.value]
        post.votes_count -= 1
        if vote.value == true
          post.up_votes_count -= 1
        else
          post.down_votes_count -= 1
        end
        post.save
      end
    end
  end
end