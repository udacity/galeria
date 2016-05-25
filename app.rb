require 'sinatra'
require 'bundler'
require 'active_record'
require 'aws-sdk'
require_relative 'models/image'
require_relative 'config/environments'

get '/' do
  @images = Image.all
  erb :index
end

get '/photo/:id' do
  @image = Image.find(params[:id])
  erb :single
end

post '/' do
  if params[:file]
    file       = params[:file][:tempfile]
    filename   = params[:file][:filename]

    s3 = Aws::S3::Resource.new(
      credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_KEY']),
      region: ENV['AWS_REGION']
    )
    obj = s3.bucket(ENV['AWS_BUCKET']).object(filename)
    obj.upload_file(file.path, acl:'public-read')


    Image.create(
      url: obj.public_url,
      title: filename
    )

    redirect '/'
  else
    redirect '/'
  end
end
