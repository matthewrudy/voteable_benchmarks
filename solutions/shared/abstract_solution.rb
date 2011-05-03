module AbstractSolution
  def create_database
    # Create data code
  end
  
  def vote(user_id, post_id, value)
    # Create vote code
  end
  
  def unvote(user_id, post_id, value)
    # Unvote vote code
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
        vote(user.id, post.id, user.happy)
      end
    end
  end

  def unvote_votes
    @users.each do |user|
      @posts.each do |post|
        unvote(user.id, post.id, user.happy)
      end
    end
  end
end
