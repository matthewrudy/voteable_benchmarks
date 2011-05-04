VOTE_POINT = {
  true => +1,
  false => -2
}

module AbstractSolution
  def create_database
    # ...
  end
  
  def vote(user_id, post_id, value)
    # ...
  end
  
  def unvote(user_id, post_id, value)
    # ...
  end
  
  def init_data
    @users = (1..TOTAL_USERS).map do |i|
      User.create(
        :name => 'Alex Nguyen',
        :happy => i % 2 == 0
      )
    end

     @posts = (1..TOTAL_POSTS).map do
      Post.create(
        :title => 'Voteable benchmarks',
        :content => 'Compare performance of voting solutions for SQL and MongoDB'
      )
    end
  end

  
  def create_votes
    @users.each do |user|
      @posts.each do |post|
        # Happy user will give positive vote
        updated_post = vote(user.id, post.id, user.happy)
        validates(:vote, user, post, updated_post)
        post.attributes = updated_post.attributes
      end
    end
  end


  def unvote_votes
    @users.each do |user|
      @posts.each do |post|
        updated_post = unvote(user.id, post.id, user.happy)
        validates(:unvote, user, post, updated_post)
        post.attributes = updated_post.attributes
      end
    end
  end


  def validates(action, user, post, updated_post)
    direction = { 
      :vote => 1,
      :unvote => -1
    }[action]
    
    unless post.votes_point == updated_post.votes_point - direction*VOTE_POINT[user.happy] &&
           post.votes_count == updated_post.votes_count - direction
      puts "#{action} ERROR"
      # puts user.inspect, post.inspect, updated_post.inspect # DEBUG
      throw StandardError
    end
  end
    
end
