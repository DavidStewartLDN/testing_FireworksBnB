require 'sinatra'
require 'sinatra/activerecord'

require './app/models/booking'
require './app/models/space'
require './app/models/user'

set :database, "sqlite3:fireworksbnb.sqlite3"

class FireworksBnB < Sinatra::Base
  get '/' do
    @users = User.all
    @spaces = Space.all
    @bookings = Booking.all
    erb :index
  end

  # Add new user

  get '/add_user' do
    erb :add_user
  end

  post '/add_user/new' do
    new_user = User.create(username: params[:new_user_name], password: params[:new_password])
    redirect '/'
  end

  # Add new Space

  get '/add_space' do
    erb :add_space
  end

  post '/add_space/new' do
    new_space = Space.create(property_name: params[:new_space_name], description: params[:new_space_description], price: params[:new_price])
    redirect '/'
  end 

  # add new Booking

  get '/add_booking' do
    erb :add_booking
  end

  post '/add_booking/new' do
    new_booking = Booking.create(start_date: params[:new_start_date], end_date: params[:new_end_date], confirmation: 'Pending')
    redirect '/'
  end 
end