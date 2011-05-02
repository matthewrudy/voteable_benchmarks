class Post
  include Mongoid::Document
  include Mongoid::Voteable

  field :title
  field :content
  
  voteable self, :up => +1, :down => -2, :index => !SKIP_ADDITIONAL_INDEXES
end
