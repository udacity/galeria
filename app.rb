require 'sinatra'
require 'bundler'
require 'active_record'
require_relative 'models/image'
require_relative 'config/environments'

get '/' do
  @images = Image.all
  erb :index
end

post '/' do
  img_num = rand(0..1084)
  Image.create(
    url: "https://unsplash.it/600/500?image=#{img_num}",
    title: "Image number #{img_num}"
  )
  redirect '/'
end

get '/photo/:id' do
  @image = Image.find(params[:id])
  erb :single
end
