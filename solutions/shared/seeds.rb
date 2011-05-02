TOTAL_USERS.times do
  User.create(
    :name => 'Alex Nguyen'
  )
end

TOTAL_POSTS.times do
  Post.create(
    :title => 'Voteable benchmarks',
    :content => 'Compare performance of voting solutions for SQL and MongoDB'
  )
end
