namespace :dev do
  desc "Rebuild System"
  task :build => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate"]
  task :rebuild => ["dev:build", "db:seed"]
  
  task :populate => "environment" do
    [Board, Post].each(&:delete_all)
    require "populator"
    require "faker"
    
    Board.populate(10) do |board|
      board.name = Populator.words(1..5).titleize
      board.created_at = 2.years.ago..Time.now
    end
    
    10.times.each do
      user = User.create!(:email => Faker::Internet.email, :password => "123456")
      Post.populate (1..5) do |post|
        board_ids = Board.select(:id)
        board_range = board_ids.size
        random_board_id = board_ids[rand(board_range)]
        post.board_id = random_board_id
        post.subject = Populator.words(1..5).titleize
        post.content = Populator.sentences(2..10)
        post.created_at = 1.year.ago..Time.now
        post.user_id = user.id
      end
    end
  end
end