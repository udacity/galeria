configure :development do
  db_options = YAML.load(File.read('./config/database.yml'))
  ActiveRecord::Base.establish_connection(db_options)
end

configure :production do
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
end
