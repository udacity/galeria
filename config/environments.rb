configure :production, :development do
  db_options = YAML.load(File.read('./config/database.yml'))
  ActiveRecord::Base.establish_connection(db_options)
end
