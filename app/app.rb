require 'sinatra'
require 'sinatra/activerecord'

require './app/models/booking'
require './app/models/space'
require './app/models/user'

set :database, "sqlite3:fireworksbnb.sqlite3"

class FireworksBnB < Sinatra::Base

  enable :sessions

  # login to users account

  get '/login' do
    erb :login
  end

  # Verify login details against database

  post '/login/validate' do
    # session[:user_entered] = params["username"]
    # session[:password_entered] = params["password"]
    # redirect '/list_all'

    if (User.exists?(username: params["username"], password: params["password"]))
      session[:user_id] = User.find_by(username: params["username"]).id
      session[:user] = params["username"]
      redirect '/list_all'
    else
      redirect '/login'
    end
  end

  # Main page listing all users, spaces and bookings

  get '/list_all' do
    # @user_entered = session[:user_entered]
    # @password_entered = session[:password_entered]
    @current_user = session[:user]
    @user_id = session[:user_id]
    @users = User.all
    @spaces = Space.all
    @bookings = Booking.all
    erb :list_all
  end

  # Add new user

  get '/add_user' do
    erb :add_user
  end

  post '/add_user/new' do
    new_user = User.create(username: params[:new_user_name], password: params[:new_password])
    redirect '/list_all'
  end

  # Add new Space

  get '/add_space' do
    erb :add_space
  end

  post '/add_space/new' do
    new_space = Space.create(property_name: params[:new_space_name], description: params[:new_space_description], price: params[:new_price])
    redirect '/list_all'
  end 

  # add new Booking

  get '/add_booking' do
    erb :add_booking
  end

  post '/add_booking/new' do
    new_booking = Booking.create(start_date: params[:new_start_date], end_date: params[:new_end_date], confirmation: 'Pending')
    redirect '/list_all'
  end 
end