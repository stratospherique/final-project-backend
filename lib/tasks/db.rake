namespace :db do
  desc 'Drop the Database, resets it and seeds it'
  task :reseed => ['db:reset', 'db:seed'] do
    puts 'reseeding competed'
  end
end