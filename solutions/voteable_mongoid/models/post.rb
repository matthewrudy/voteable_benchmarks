class Post
  include Mongoid::Document
  include Mongo::Voteable

  field :title
  field :content
  
  voteable self, 
    :up => VOTE_POINT[true],
    :down => VOTE_POINT[false],
    :index => !SKIP_ADDITIONAL_INDEXES
end
