class Vote
  include Mongoid::Document

  index [['post_id', 1]]
  index [['user_id', 1]]
end
