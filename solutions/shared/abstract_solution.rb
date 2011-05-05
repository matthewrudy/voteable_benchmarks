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
        :happy => i%2 ==0
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
        vote(user.id, post.id, user.happy)
      end
    end
    verify_all_votes!
  end


  def unvote_votes
    @users.each do |user|
      @posts.each do |post|
        updated_post = unvote(user.id, post.id, user.happy)
      end
    end
    verify_no_votes!
  end

  def verify_all_votes!
    @posts.each do |post|
      post.reload
      happy_users   = TOTAL_USERS / 2
      unhappy_users = TOTAL_USERS - happy_users
      
      assert_equal TOTAL_USERS, post.votes_count, "post vote count"
      assert_equal happy_users-(unhappy_users*2), post.votes_point, "post vote points"
      assert_equal happy_users, post.up_votes_count, "post up votes"
      assert_equal unhappy_users, post.down_votes_count, "post down votes"
    end
  end

  def verify_no_votes!
    @posts.each do |post|
      post.reload
      assert_equal 0, post.votes_count, "post vote count"
      assert_equal 0, post.votes_point, "post vote points"
      assert_equal 0, post.up_votes_count, "post up votes"
      assert_equal 0, post.down_votes_count, "post down votes"
    end
  end
  
  def assert_equal(expected, actual, message=nil)
    if expected != actual
      raise "expected #{expected} but got #{actual}\n#{message}"
    end
  end
    
end
