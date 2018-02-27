namespace :test_task do
  desc 'Generate doors'
  task :seed_doors => :environment do
    (1..45).to_a.each do |i|
      file_path = Rails.root.join('lib','door_images',"#{i}.jpg")
      Door.create img: File.open(file_path)
    end
    Door.last.update_column :final, true
  end
end