namespace :users do
  desc "reset user points"
  task :update => :environment do
    @heroes = User.order("points DESC").all[0..2]
    puts "Heroes are: #{@heroes.map(&:name).join(",")}"

    User.all.each do |u|
      if @heroes.include? u
        u.hero = true
      else
        u.hero = false
      end
      u.points = 0
      u.save
    end
  end
end