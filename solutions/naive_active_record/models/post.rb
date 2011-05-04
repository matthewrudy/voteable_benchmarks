class Post < ActiveRecord::Base
  include Voteable
  has_many :votes
end
