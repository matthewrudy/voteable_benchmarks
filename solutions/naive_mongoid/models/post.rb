class Post
  include Mongoid::Document
  include Voteable

  field :title
  field :content
  
  field :votes_point, :type => Integer, :default => 0
  field :votes_count, :type => Integer, :default => 0
  field :up_votes_count, :type => Integer, :default => 0
  field :down_votes_count, :type => Integer, :default => 0

  unless SKIP_ADDITIONAL_INDEXES  
    index [['votes_point', -1]]
    index [['votes_count', -1]]
    index [['up_votes_count', -1]]
    index [['down_votes_count', -1]]
  end
end
