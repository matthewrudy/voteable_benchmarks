class Post
  include MongoMapper::Document
  include Mongo::Voteable

  key :title, String
  key :content, String
  
  voteable self,
    :up => VOTE_POINT[true],
    :down => VOTE_POINT[false],
    :index => !SKIP_ADDITIONAL_INDEXES
end
