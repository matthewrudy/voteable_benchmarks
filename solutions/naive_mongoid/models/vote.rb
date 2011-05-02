class Vote
  include Mongoid::Document
  index [['post_id', 1], ['user_id', 1]]
end
